Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUIMOh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUIMOh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUIMOhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:37:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:11961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267568AbUIMOeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:34:02 -0400
Date: Mon, 13 Sep 2004 07:33:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
In-Reply-To: <Pine.GSO.4.58.0409131616390.23648@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0409130729000.2378@ppc970.osdl.org>
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com>
 <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org> <414508F6.7020301@pobox.com>
 <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org>
 <Pine.GSO.4.58.0409131616390.23648@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Sep 2004, Geert Uytterhoeven wrote:
> 
> While resuming adding __user annotations to the m68k-specific parts of the
> code, I stumbled on
> 
>     struct task_struct {
> 	...
> 	unsigned long sas_ss_sp;
> 	...
>     }
> 
> If I'm not mistaken, sas_ss_sp is always a pointer to user stack space.
> Shouldn't it be changed to `void __user *sas_ss_sp', or is an
> unsigned long/void * change in generic code a too controversial change for
> making sparse happy?

I don't think it's too controversial per se, and it would certainly remove 
at least two casts from kernel/signal.c. Are you ready to fix up some 
other architectures from the fall-out (x86 at the least..)

		Linus
