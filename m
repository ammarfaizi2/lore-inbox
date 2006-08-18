Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWHRLNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWHRLNB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWHRLNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:13:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55255 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932417AbWHRLM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:12:59 -0400
Message-ID: <44E5A0B9.9090502@pobox.com>
Date: Fri, 18 Aug 2006 07:12:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/6] IP100A correct init and close step
References: <1155841712.4532.19.camel@localhost.localdomain> <44E48281.1060504@pobox.com> <02ea01c6c28d$20943940$4964a8c0@icplus.com.tw>
In-Reply-To: <02ea01c6c28d$20943940$4964a8c0@icplus.com.tw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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



