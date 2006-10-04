Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWJDJNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWJDJNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160997AbWJDJNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:13:14 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:50326 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1030548AbWJDJNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:13:13 -0400
Date: Wed, 4 Oct 2006 11:14:20 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] libata AHCI reset speed-up, improvements
Message-ID: <20061004091419.GA5683@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060927025639.GA16969@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927025639.GA16969@havoc.gtf.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeff Garzik <jeff@garzik.org>:
> Subject: [PATCH][RFT] libata AHCI reset speed-up, improvements
> 
> 
> This patch, diff'd against 2.6.18-git5 (or later), attempts the
> following improvements:
> 
> * Speed up reset, by polling rather than unconditionally sleeping
>   for one seconds.
> * Save the Ports-Implemented register across controller resets.
> * Verify that AHCI mode was truly enabled.
> 
> I'm quite interested in hearing people's test feedback on this patch.
> On my own ICH7 machine, it introduces a "softreset failed" error, but
> EH recovers nicely and nonetheless configures everything successfully.
> Probably just a slow ATAPI device, but I may have exposed a latent
> problem in the driver that was hidden until now by the ssleep(1).

Hi Jeff!
I tested this patch on my T60 (Intel ICH7) 
against git 78b656b8bf933101b42409b4492734b23427bfc3
with the same result: during boot, I get
scsi0: ahci
ata1: port is slow to respond, pls be patient
ata1: port failed to respond (30 sec)
ata1: soft reset failed (device not ready)
ata1: soft reset failed retrying in 5 secs
etc

after a while everything recovers and seems to work OK
afterwards, but still this seems to add about a minute or so
to the boot time.

I'm not sure how to test whether I get the speedup that you
mention.

Hope this report helps.


-- 
MST
