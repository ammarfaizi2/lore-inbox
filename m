Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSKEFsP>; Tue, 5 Nov 2002 00:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSKEFsP>; Tue, 5 Nov 2002 00:48:15 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3716 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264883AbSKEFsO>; Tue, 5 Nov 2002 00:48:14 -0500
Date: Mon, 04 Nov 2002 21:51:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <3838782677.1036446674@[10.10.2.3]>
In-Reply-To: <20021105042616.GB21914@pegasys.ws>
References: <20021105042616.GB21914@pegasys.ws>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And i'd still keep environ seperate.  I'm inclined to think
> ps should never have presented it in the first place.
> This is the direction i (for what it's worth) favor.

If it doesn't need it then sure, otherwise just dump whatever
it needs in there. The seperate files would still be there too.
 
> Yep, can't hold the lock across syscalls.  That would be
> quite a bit of data to hold in a per fd buffer.  Think of
> the big iron with tons of processes.

I *have* the big iron with tons of processes ;-) That's why
I care ...
 
> The other way i could see this working is to present it as a
> sparse file.  ps (or whatever) would first get a list of
> pids then iterate over them using lseek to set the file
> offset to pid * CONSTANT_SIZE and read would return
> something smaller than CONSTANT_SIZE bytes.  If the pid no
> longer exists return 0.
> 
> I really hate this idea.  It stinks almost as much as
> /dev/kmem.

Well if we want to be gross and efficient, we could just compile
a kmem-diving dynamic library with every kernel compile and stick
it in /boot or somewhere. Mildly less extreme is a flat index file
for the data you need a la System.map. Then just open /dev/kmem
and grab what you want. Walking the tasklist with no locking would
be an interesting challenge, but probably not insurmountable. 
That's how things like ps always used to work IIRC.

M.

