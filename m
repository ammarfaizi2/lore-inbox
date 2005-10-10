Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVJJS13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVJJS13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVJJS13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:27:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbVJJS12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:27:28 -0400
Date: Mon, 10 Oct 2005 11:23:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: tony.luck@gmail.com, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/platform.h
Message-Id: <20051010112341.7bb116ae.akpm@osdl.org>
In-Reply-To: <20051003215053.GI3652@stusta.de>
References: <20050902205204.GU3657@stusta.de>
	<Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net>
	<20051001233414.GG4212@stusta.de>
	<12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com>
	<20051003190345.GH3652@stusta.de>
	<12c511ca0510031407i5266cf4ak5082ec54f60a3d17@mail.gmail.com>
	<20051003215053.GI3652@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Mon, Oct 03, 2005 at 02:07:12PM -0700, Tony Luck wrote:
>  > > The default_idle() prototype should stay inside some header file.
>  > 
>  > That would be best, yes.
>  > 
>  > > @Patrick:
>  > > Any suggestion where it should move to?
>  > 
>  > Of the include files already included directly by arch/ia64/kernel/setup.c,
>  > <linux/sched.h> looks the most promising.  There's lots of .*idle.* things
>  > already in there.
>  > 
>  > Looking at existing precedent: ppc64 has a definition of default_idle()
>  > in <asm/machdep.h>
> 
>  The question whether linux/ or asm/ is the best place for the definition 
>  boils down to the question whether it is expected that default_idle() is 
>  present on all architectures or whether it's an architecture-specific 
>  implementation detail.

Yes, default_idle() is arch-specific and so its prototype should be in an
arch-specific header.

All the implementations happen to have the same signature, so it's tempting
to put the prototype into some generic header, but given that there's no
non-arch-specific caller, we shouldn't do that.

