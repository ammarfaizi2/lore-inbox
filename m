Return-Path: <linux-kernel-owner+w=401wt.eu-S1755218AbXAAPVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbXAAPVU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 10:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbXAAPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 10:21:19 -0500
Received: from usul.saidi.cx ([204.11.33.34]:47724 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755218AbXAAPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 10:21:19 -0500
Message-ID: <459926B5.60505@overt.org>
Date: Mon, 01 Jan 2007 07:20:21 -0800
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: linux-kernel@vger.kernel.org, John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards
References: <458C22C0.1080307@vmware.com> <4597A327.8030408@drzeus.cx>
In-Reply-To: <4597A327.8030408@drzeus.cx>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will post the updated diff as a separate follow up.

Pierre Ossman wrote:
> 
> When you have a commit message larger than the patch, you know there is
> something wrong. ;)
> 
> Please skip the part about MMC at least.

Heh. I forget that you don't want to manually alter the email. Will do.

> 
> Actually, the way the spec describes version 2.0 of the CSD leaves my
> stomach a bit upset. I think we will find cards that put bogus values in
> the fields, expecting most hosts to use the well defined values. So I'd
> prefer a switch statement here, where csd_struct == 1 results in hard
> coded values for many fields.

I'm less pessimistic than you about this, but I have no problems with
hard-coding.

>> +	cmd.opcode = SD_SEND_IF_COND;
>>   
> 
> Put this in mmc_setup() with the rest of the initialisation. Hiding in
> here just confuses things.

Done. I thought we needed it before both SD_APP_SEND_OP_COND calls but
it's only needed before the second one so I've moved it inline into
mmc_setup.

> Also, please add a comment about why you manipulate the ocr.

Done.

> 
> Wrong. R7 is defined as MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE.
> 
> (So is R6 btw, wonder why that is...)

Ah - I knew they were both the same so I made R7 match R6. :-)

I've added OPCODE to both.

Thanks,

--phil
