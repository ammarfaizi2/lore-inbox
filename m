Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272271AbTHOW7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272290AbTHOW7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:59:13 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:32775 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272271AbTHOW7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:59:12 -0400
Date: Fri, 15 Aug 2003 23:59:11 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Kurt Roeckx <Q@ping.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with framebuffer in 2.6.0-test3
In-Reply-To: <20030815224652.GA335@ping.be>
Message-ID: <Pine.LNX.4.44.0308152348071.30952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I disabled CONFIG_FB_VGA16 and CONFIG_FB_VESA now I get:

I think the issue is that only one framebuffer is mapped to the console.
VESA sets the graphics state before any fbdev drivers are registered. I 
believe that vga16fb is registered to the console. Because vga16fb expects 
a different hardware state than what VESA has done you get the problems 
you experience.
 
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x742cb): In function `tdfxfb_imageblit':
> : undefined reference to `cfb_imageblit'
> make: *** [.tmp_vmlinux1] Error 1

??? That shouldn't happen.


