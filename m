Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWIKFTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWIKFTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWIKFTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:19:04 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:43536 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S932149AbWIKFTC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:19:02 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: TG3 data corruption (TSO ?)
Date: Sun, 10 Sep 2006 22:18:52 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FB2B@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <1157950410.31071.402.camel@localhost.localdomain>
Thread-Topic: TG3 data corruption (TSO ?)
thread-index: AcbVXkYtG843IkUSRImfIiBxQPgC/gAApzdg
From: "Michael Chan" <mchan@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
cc: "Segher Boessenkool" <segher@kernel.crashing.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006091101; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230352E34353034463032302E303031342D422D306A7671374D75736C6841666147687761704E7344673D3D;
 ENG=IBF; TS=20060911051854; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006091101_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 691A2E373CC6197401-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> I've added a wmb() in tw32_rx_mbox() and tw32_tx_mbox() and can still
> reproduce the problem. I've also done a 2 days run without TSO enabled
> without a failure (my test program normally fails after a couple of
> minutes).
> 

Hi Ben,

The code is a bit tricky.  It uses function pointers for the various
register read/write methods.  For the 5780, I believe it will be
assigned a simple writel() and not tg3_write32_tx_mbox().  Can you
double check to make sure you have actually added the wmb()?

It's probably easiest to just add the wmb() in tg3_xmit_dma_bug()
before the tw32_tx_mbox().

