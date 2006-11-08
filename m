Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754292AbWKHFXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbWKHFXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbWKHFXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:23:13 -0500
Received: from mail01.verismonetworks.com ([164.164.99.228]:33713 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1754290AbWKHFXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:23:12 -0500
Subject: Re: [PATCH] drivers/scsi/mca_53c9x.c : save_flags()/cli() removal
From: Amol Lad <amol@verismonetworks.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@steeleye.com,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061107222946.GA20332@infradead.org>
References: <1162816931.22062.132.camel@amol.verismonetworks.com>
	 <20061107222946.GA20332@infradead.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 10:56:25 +0530
Message-Id: <1162963585.22062.173.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 22:29 +0000, Christoph Hellwig wrote:
> On Mon, Nov 06, 2006 at 06:12:11PM +0530, Amol Lad wrote:
> > Replaced save_flags()/cli() with spin_lock alternatives
> 
> This patch has very little chance to work as-is because it only replaces
> cli with spinlocks, but not the irq handler it's locking against.
> 
It protects against irq handler also. 

drivers/scsi/NCR53C9x.c:

irqreturn_t esp_intr(int irq, void *dev_id)
{
    struct NCR_ESP *esp;
    unsigned long flags;
    int again;
    struct Scsi_Host *dev = dev_id;

    /* Handle all ESP interrupts showing at this IRQ level. */
    spin_lock_irqsave(dev->host_lock, flags);
...
...
}


