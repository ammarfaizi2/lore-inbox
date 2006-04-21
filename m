Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWDUQko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWDUQko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWDUQkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:40:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751285AbWDUQkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:40:42 -0400
Date: Fri, 21 Apr 2006 09:40:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <200604211121.20036.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0604210932020.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
 <200604211121.20036.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Apr 2006, Alistair John Strachan wrote:
> 
> Something in here (or -rc1, I didn't test that) broke WINE. x86-64 kernel, 
> 32bit WINE, works fine on 2.6.16.7. I'll check whether -rc1 had the same 
> problem and work backwards, but just in case somebody has an idea..

Nothing strikes me, but maybe Andi has a clue.

> [alistair] 11:17 [~/.wine/drive_c/Program Files/Warcraft III] wine 
> war3.exe -opengl
> wine: Unhandled page fault on write access to 0x00495000 at address 0x495000 
...


> Unhandled exception: page fault on write access to 0x00495000 in 32-bit code 

That looks bogus. %eip is 0x00495000, and might well have taken a fault, 
but it sure ain't a write access. According to the built-in wine debugger 
it was

> 0x00495000 EntryPoint in war3: pushl    %eax

which does do a write, but to %esp (which is 7f9eff0c according to the 
dump, and which is unlikely to have taken a fault, since it's almost 256 
bytes off the end of a page in the stack area).

Alistair, if you can do a "git bisect" on this one, that would help. 
Unless Andi goes "Duh!".

		Linus
