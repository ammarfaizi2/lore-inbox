Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTI1SYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTI1SYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:24:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:50359 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262655AbTI1SYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:24:49 -0400
Date: Sun, 28 Sep 2003 11:24:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 do_machine_check() is redundant.
In-Reply-To: <3F770C4F.5020407@quark.didntduck.org>
Message-ID: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Brian Gerst wrote:
>
> Use machine_check_vector in the entry code instead.

This is wrong. You just lost the "asmlinkage" thing, which means that it 
breaks when asmlinkage matters.

And yes, asmlinkage _can_ matter, even on x86. It disasbles regparm, for
one thing, so it makes a huge difference if the kernel is compiled with
-mregparm=3 (which used to work, and which I'd love to do, but gcc has
often been a tad fragile).

		Linus

