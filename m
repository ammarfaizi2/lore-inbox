Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265314AbSKEXEu>; Tue, 5 Nov 2002 18:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265315AbSKEXEu>; Tue, 5 Nov 2002 18:04:50 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62431 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265314AbSKEXEt>;
	Tue, 5 Nov 2002 18:04:49 -0500
Date: Tue, 05 Nov 2002 16:06:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <26610000.1036541181@flay>
In-Reply-To: <15816.19206.959160.739312@wombat.chubb.wattle.id.au>
References: <15816.19206.959160.739312@wombat.chubb.wattle.id.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> And i'd still keep environ seperate.  I'm inclined to think ps
>>> should never have presented it in the first place.  This is the
>>> direction i (for what it's worth) favor.
> 
> Martin> If it doesn't need it then sure, otherwise just dump whatever
> Martin> it needs in there. The seperate files would still be there
> Martin> too.
> 
> Why not make an mmapable file in /proc  with everything in it?
> It can be sparse, so have the first part a bit map to say what
> processes are active, then just look at the bits you need.
> That gets rid of all but the open and mmap system call.

The locking of walking the tasklist seems non-trivial, but we may well
end up with something like that. By the time you finish, it looks more
like a /dev device thing than /proc (which I'm fine with), and looks
rather like the patch that was posted earlier in this thread. Ideally
I'd like fewer ioctls than that, and lower syscall overhead, but it
seems much closer to functional than the current system.

M.

