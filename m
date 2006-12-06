Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760368AbWLFJT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760368AbWLFJT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760370AbWLFJT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:19:26 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:31808 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760366AbWLFJTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:19:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=UohFSIiLBvepFV+Nkbt8q8MC088x6N3ciXlY8juHdKb5TLi3Ao2USvZHT2FAj8Hq6Hm128iV/UC8w+vcAPLI5Y5xDa8+TLnry7vZk1kZ4nkIbcPCQM8ighm5dNmvKJFEszhOEzqF7s0msx8QPqzMARFfesQKva+bq2ctkGF6V+A=
Message-ID: <45768B16.5020603@gmail.com>
Date: Wed, 06 Dec 2006 18:19:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
References: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
In-Reply-To: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
>> Don't freeze port unconditionally.  You'll end up hardresetting on every
>> error.  Just make sure DMA engine is stopped and the controller is in a
>> sane state.  If that fails, then, the port should be frozen.

Sorry, s/hardresetting/resetting/

> I'm looking into this now, but so far it seems only a reset
> (what Promise calls software reset, I don't know if libata
> considers it a soft or hard reset) of the ATA channel will do.

Errors properly reported by the device shouldn't cause resets.  Think
about ATAPI check condition.

>>> +	hardreset = NULL;
>>> +	if (sata_scr_valid(ap)) {
>>> +		ehc->i.action |= ATA_EH_HARDRESET;
>> Why always force HARDRESET?
> 
> I based that on sata_sil24:
> 
> 	if (sil24_init_port(ap)) {
> 		ata_eh_freeze_port(ap);
> 		ehc->i.action |= ATA_EH_HARDRESET;
> 	}
> 
> I interpreted the ATA_EH_HARDRESET as being required due to
> the ata_eh_freeze_port(), but perhaps it's only there because
> sil24_init_port() returned failure?

Yeap, that's right.

> A different issue, but of practical importance, is which
> libata branch I should base the EH conversion on: #upstream
> or #ALL? Andrew Morton's -mm kernels include the ALL patches,
> but they in turn include the promise-sata-pata patches, and
> there is a conflict between the PATA patch and the EH conversion.
> Currently my EH conversion is based on #upstream, and I've ported
> the PATA patch to apply on top of it.

#upstream, It is.  #ALL is merge of all libata-dev devel branches and no
development work occurs there directly.

Thanks.

-- 
tejun
