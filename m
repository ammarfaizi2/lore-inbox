Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSKDPJP>; Mon, 4 Nov 2002 10:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264700AbSKDPJP>; Mon, 4 Nov 2002 10:09:15 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:53701 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264699AbSKDPJO> convert rfc822-to-8bit; Mon, 4 Nov 2002 10:09:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Mon, 4 Nov 2002 09:13:45 -0600
User-Agent: KMail/1.4.1
Cc: Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
References: <Pine.LNX.4.44.0211022040140.2541-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211022040140.2541-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211040913.45549.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 November 2002 10:54 pm, Linus Torvalds wrote:
> On Sat, 2 Nov 2002, Alexander Viro wrote:
> > No, that's OK -
> >
> > mount --bind /usr/bin/foo.real /usr/bin/foo.real
> > mount -o remount,nosuid /usr/bin/foo.real
>
> Ehh. With the nosuid mount that will remove the effectiveness of the suid
> bit (not just the user change - it will also mask off the elevation of the
> capabilities), so the bind-mount with the capability mask will now mask
> off nothing to start with.
>
> Wouldn't it be much nicer to have:
>
>   /usr/bin/foo - no suid bits, no capabilities by default
>
>   mount --bind --capability=xx,yy /usr/bin/foo /usr/bin/foo
>
> where the mount actually adds capabilities? Looks more understandable to
> me.

Only until the file the path name is connected to is replaced. Then the
trojan suddenly gains the capabilities of the real "foo".

Been there done that. That was one of the first security vulnerabilities
in the VMS implementation of ACLs.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
