Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbTCHU6Q>; Sat, 8 Mar 2003 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbTCHU6Q>; Sat, 8 Mar 2003 15:58:16 -0500
Received: from terminus.zytor.com ([63.209.29.3]:30643 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S262212AbTCHU6P>; Sat, 8 Mar 2003 15:58:15 -0500
Message-ID: <3E6A5BC2.6040808@zytor.com>
Date: Sat, 08 Mar 2003 13:08:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>	<20030307233916.Q17492@flint.arm.linux.org.uk>	<m1d6l2lih9.fsf@frodo.biederman.org>	<20030308100359.A27153@flint.arm.linux.org.uk>	<m18yvpluw7.fsf@frodo.biederman.org>	<20030308161309.B1896@flint.arm.linux.org.uk> <m1vfytkbsk.fsf@frodo.biederman.org>
In-Reply-To: <m1vfytkbsk.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> I don't recall anything about the contents of initramfs being specified.
> What I was expecting to see was a good set of general purpose policies
> being included in the default kernel binary.  And just replacing
> /sbin/kinit if I wanted something dramatically different.  And that is
> what I remember Al Viro working on.
> 
> So I don't think building a very specific /sbin/kinit that
> only does what the kernel currently does right now is a problem.
> 

It does matter how the initramfs is built.  /bin/sh may or may not be 
necessary (but klibc /bin/sh is just over 50K on i386 -- 55K static, 
whereas glibcx /bin/bash is 600K plus the glibc binary), but one of the 
goals with initramfs is to at least make it feasible to give someone who 
comes and asks "I have a weird-ass site with 20000 hosts and we need X" 
a better answer then "well, go hack the kernel."

/sbin/kinit is a feasible way to do it, but it's important to keep the 
flexibility option open.

> So I think we should have a very small very specific /sbin/kinit
> that does in user space what the kernel does in kernel space right
> now.  Regardless of klibc the default /sbin/kinit should be gpl'd
> because we are moving code from code from the kernel into it, and we
> shouldn't need to double check the licenses to move code from the
> kernel into it.

Agreed (although it's harder than you think to move code from the kernel 
into it -- frequently it has been easier to just write code from 
scratch; it's cleaner that way, too.)

The reason I wanted to use BSD/MIT license only really applies to the 
library.

	-hpa

