Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVI2UBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVI2UBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVI2UB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:01:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964879AbVI2UB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:01:29 -0400
Date: Thu, 29 Sep 2005 13:00:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Deepak Saxena <dsaxena@plexity.net>
cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Fix IXP4xx MTD driver no cast warning
In-Reply-To: <20050929195205.GA30002@plexity.net>
Message-ID: <Pine.LNX.4.58.0509291259110.3308@g5.osdl.org>
References: <20050929195205.GA30002@plexity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Deepak Saxena wrote:
> 
> drivers/mtd/maps/ixp4xx.c: In function 'ixp4xx_flash_probe':
> drivers/mtd/maps/ixp4xx.c:199: warning: assignment makes integer from
> pointer without a cast

Please don't. The warning is entirely warranted, as far as I can tell.

Shutting up warnings just because they are warnings is bad practice. 
Either fix them, or leave them be.

If you do an "ioremap()", then the result is a "(void __iomem *)". If you 
assign it to something that is "unsigned long", you _should_ get a 
warning.

		Linus
