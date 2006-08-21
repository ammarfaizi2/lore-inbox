Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWHUDiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWHUDiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 23:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWHUDiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 23:38:11 -0400
Received: from msr8.hinet.net ([168.95.4.108]:46485 "EHLO msr8.hinet.net")
	by vger.kernel.org with ESMTP id S932551AbWHUDiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 23:38:09 -0400
Message-ID: <006101c6c4d3$2e224820$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>
References: <1155841712.4532.19.camel@localhost.localdomain> <44E48281.1060504@pobox.com> <02ea01c6c28d$20943940$4964a8c0@icplus.com.tw> <44E5A0B9.9090502@pobox.com>
Subject: Re: [PATCH 5/6] IP100A correct init and close step
Date: Mon, 21 Aug 2006 11:37:51 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:

(3)Yes, This is a bug, I will correct it. Thanks.

(4)This will halt TxDMA and RxDMA, after that will let reseting safely.
Should I add description in source code or in change log?

Thanks!

Jesse

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>
Sent: Friday, August 18, 2006 7:12 PM
Subject: Re: [PATCH 5/6] IP100A correct init and close step


Jesse Huang wrote:
> Hi Jeff:
> (1)Should I change to :
> spin_lock_irqsave(&np->lock,flags);
> reset_tx(dev);
> spin_lock_irqrestore(&np->lock,flags);
>
> (2)I will remove date and author information out of source code comment.

Correct.

Also:

(3) Use iowrite16(), not writew().  I just noticed this bug.
iowrite16() will work for both MMIO and IO cycles, writew() only works
for MMIO.

(4) We need a description of why this change is needed.  What does
writing 0x500 to DMACtrl actually do?  Why do we need to do this?

Jeff



