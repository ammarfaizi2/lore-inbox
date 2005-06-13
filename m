Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVFMN4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVFMN4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFMN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:56:39 -0400
Received: from ns1.suse.de ([195.135.220.2]:2779 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261575AbVFMN40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:56:26 -0400
Message-ID: <42AD9089.5080006@suse.de>
Date: Mon, 13 Jun 2005 15:56:25 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT][PATCH] aic79xx: remove busyq
References: <20050529074620.GA26151@havoc.gtf.org>
In-Reply-To: <20050529074620.GA26151@havoc.gtf.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Can anyone with aic79xx hardware give me a simple "it works"
> or "this breaks things" answer, for the patch below?
> 
> This changes the aic79xx driver to use the standard Linux SCSI queueing
> code, rather than its own.  After applying this patch, NO behavior
> changes should be seen.
> 
> The patch is against 2.6.12-rc5, but probably applies OK to recent 2.6.x
> kernels.
> 
Hmm. Does not quite work here:

scsi0: Starting DV
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec 29320 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or 66Mhz,
512 SCBs

In DV Thread
scsi0: Beginning Domain Validation
scsi0:A:0:0: Performing DV
scsi0:2223: Going from state 0 to state 1
scsi0:A:0:0: Sending INQ
scsi0: Timeout while doing DV command 12.

And from there all hell breaks loose.

It looks as if it simply refuses to send any commands ...
Investigating.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
