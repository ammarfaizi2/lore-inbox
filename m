Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVLNHH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVLNHH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLNHH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:07:26 -0500
Received: from [85.8.13.51] ([85.8.13.51]:47281 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751291AbVLNHH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:07:26 -0500
Message-ID: <439FC4A6.4010900@drzeus.cx>
Date: Wed, 14 Dec 2005 08:07:18 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
References: <20051213213208.303580000@localhost.localdomain> <439F4AD6.9090203@indt.org.br>
In-Reply-To: <439F4AD6.9090203@indt.org.br>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> [resending summary because our first attempt failed]
> 
> 
> - Password caching: when inserting a locked card, the driver should try to
>   unlock it with the currently stored password (if any), and if it fails,
>   revoke the key containing it and fallback to the normal "no password present"
>   situation.
> 

Would it be possible to use the id of the card as a search key for the
password? That way several passwords can coexist.

> - Currently, some host drivers assume the block length will always be a power
>   of 2. This is not true for the MMC_LOCK_UNLOCK command, which is a block
>   command that accepts arbitratry block lengths. We have made the necessary
>   changes to the omap.c driver (present on the linux-omap tree), but the same
>   needs to be done for other hosts' drivers.
> 

The MMC layer is designed that way, so it's hardly surprising that
drivers have been coded for it. I'm assuming you've removed blksz_bits
in favor of something in bytes?

Rgds
Pierre
