Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbULOE1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbULOE1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbULOE1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:27:17 -0500
Received: from ns.suse.de ([195.135.220.2]:44216 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261865AbULOE1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:27:13 -0500
Date: Wed, 15 Dec 2004 05:27:04 +0100
From: Andi Kleen <ak@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Andi Kleen <ak@suse.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
Message-ID: <20041215042704.GE27225@wotan.suse.de>
References: <380350F3EC1@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380350F3EC1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:01:12PM +0100, Petr Vandrovec wrote:
> On 14 Dec 04 at 8:45, Andi Kleen wrote:
> > > #define TOLM                            \
> > >                 "pushl %%cs\n"          \
> > >                 "pushl $91f\n"          \
> > >                 "ljmpl $0x33,$90f\n"    \
> > 
> > It's useless, there is nothing in the kernel code that checks the 
> > 32bit segment.
> 
> ???  Processor checks for 32bit/64bit segment.  It is impossible to load
> upper 32bit of all registers with non-zero value or call 64bit
> syscall entry point from 32bit mode.  As x86-64 kernel offers 64bit 
> interface through syscall only, only way how to issue 64bit system call
> is using syscall instruction in 64bit code.

Ah sorry. I misread the intention of your code. I thought you wanted
to do it the other way round - 32bit syscall from 64bit code.
I just wanted to point out that you can do it directly without
changing the code segment, as long as you use int $0x80.

>From 64bit-from-32bit the lcall is needed agreed. However as a 
warning it will not work for all calls since a few check a bit
in task_struct that says if the process is 32bit or 64bit
(rather rare though, most prominent is signal handling) 

> 
> Or are you trying to say that these samples do not work and you cannot
> call 64bit entry point from 32bit app, or vice versa?  Then I'm afraid
> that you are not completely right, as these samples do work...

I haven't ever tried it, but I see no reason it cannot work.

-Andi
