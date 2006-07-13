Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWGMLph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWGMLph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWGMLph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:45:37 -0400
Received: from spirit.analogic.com ([204.178.40.4]:29449 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751516AbWGMLph convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:45:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 13 Jul 2006 11:45:23.0715 (UTC) FILETIME=[D3896530:01C6A671]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
Subject: Re: [PATCH] tpm: interrupt clear fix
Date: Thu, 13 Jul 2006 07:45:23 -0400
Message-ID: <Pine.LNX.4.61.0607130743370.10732@chaos.analogic.com>
In-Reply-To: <1152738113.5347.33.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] tpm: interrupt clear fix
Thread-Index: AcamcdOyiLmUbDHmTh+bqg3P2nDTww==
References: <1152738113.5347.33.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kylene Jo Hall" <kjhall@us.ibm.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "TPM Device Driver List" <tpmdd-devel@lists.sourceforge.net>,
       <akpm@osdl.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jul 2006, Kylene Jo Hall wrote:

> Under stress testing I found that the interrupt is not always cleared.
> This is a bug and this patch should go into 2.6.18 and 2.6.17.x.
>
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> ---
> --- tcg/tpmdd/drivers/char/tpm/tpm_tis.c	2006-06-07 11:37:08.000000000 -0700
> +++ linux-2.6.17/drivers/char/tpm/tpm_tis.c	2006-07-10 12:58:28.000000000 -0700
> @@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
> 	iowrite32(interrupt,
> 		  chip->vendor.iobase +
> 		  TPM_INT_STATUS(chip->vendor.locality));
> +	mb();
> 	return IRQ_HANDLED;
> }

PCI devices need a final read to flush all pending writes. Whatever
mb() does, just hides the problem.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.63 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
