Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTKNUZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTKNUZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:25:11 -0500
Received: from gaia.cela.pl ([213.134.162.11]:60683 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264339AbTKNUZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:25:04 -0500
Date: Fri, 14 Nov 2003 21:24:11 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Solar Designer <solar@openwall.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311122319580.18399-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.44.0311142109590.14447-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I've said it doesn't respond to pings.  As far as I can tell the 
> processor might as well be doing a cli hlt.  As for X - I've had X crash 
> (many) times and never in an unrestorable way - usually you can login from 
> the network or hit my hotkey Fn+\ for bios vm86 int 10 screen reset...

Well, I've just had the machine crash another two times, the first time I 
thought it might have been a different bug, but looking back it was the 
same issue.  This time the lockup happened during an ssh session in an 
xterm under X - ie. no disk access, no strace/ptrace.  Again it happened 
during screen update (half a character line on screen, the other half 
still containing the old chars) - obviously this is an Xserver 
Cyber9525DVD issue.  It would seem though that strace and ide access 
greatly increase the probability of a hang happening.  I'm wondering if 
there is any way to get the Xserver running without iopl(3) but using 
ioperm instead - I know that the io bitmap is only 0x400 ports, could this 
possibly be changed to encompass all 0x10000 ports and then redirect 
iopl(n) to ioperm(0,0x10000,n==3), plus patch sigsegv handler to ignore 
cli/sti, thus forcing interrupts to always remain enabled.  Cause that's 
where the problem seems to live.  This would probably allow at least a 
trace via serial console, etc...

Any ideas on how to trace this down (no nmi watchdog available)?

Cheers,
MaZe.


