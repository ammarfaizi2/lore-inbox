Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWFNDmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWFNDmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 23:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWFNDmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 23:42:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9931
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932389AbWFNDmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 23:42:17 -0400
Date: Tue, 13 Jun 2006 20:42:32 -0700 (PDT)
Message-Id: <20060613.204232.127674264.davem@davemloft.net>
To: luke.adi@gmail.com
Cc: samuel@sortiz.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol
 stack
From: David Miller <davem@davemloft.net>
In-Reply-To: <489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
References: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
	<489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luke Yang" <luke.adi@gmail.com>
Date: Wed, 14 Jun 2006 10:29:19 +0800

>  For "struct irda_device_info" in irda.h:
> struct irda_device_info {
>        __u32       saddr;    /* Address of local interface */
>        __u32       daddr;    /* Address of remote device */
>        char        info[22]; /* Description */
>        __u8        charset;  /* Charset used for description */
>        __u8        hints[2]; /* Hint bits */
> };
>   The "hints" member aligns at the third byte of a word, an odd
> address. So if we visit "hints" as a short in irlmp.c:
> 
>    u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> 
>  will cause alignment problem on some machines. Architectures with
> strict alignment rules do not allow 16-bit read on an odd address. I
> use le16_to_cpu to do the converting.
> 
> Signed-off-by: Luke Yang <luke.adi@gmail.com>

This looks good, I will apply it, thanks a lot.
