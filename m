Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWBBVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWBBVVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWBBVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:21:38 -0500
Received: from mgw-ext01.nokia.com ([131.228.20.93]:992 "EHLO
	mgw-ext01.nokia.com") by vger.kernel.org with ESMTP id S932252AbWBBVVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:21:37 -0500
Message-ID: <43E25ECB.5010104@indt.org.br>
Date: Thu, 02 Feb 2006 15:34:35 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] MMC OMAP driver
References: <43DF6750.1060505@indt.org.br> <20060201124434.GC3072@flint.arm.linux.org.uk> <20060201194724.GD15939@atomide.com>
In-Reply-To: <20060201194724.GD15939@atomide.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2006 19:33:05.0066 (UTC) FILETIME=[7CE600A0:01C6282F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren wrote:
> * Russell King <rmk+lkml@arm.linux.org.uk> [060201 04:44]:
>>>+static inline int is_broken_card(struct mmc_card *card)
>>>+{
>>>+	int i;
>>>+	struct mmc_cid *c = &card->cid;
>>>+	static const struct broken_card_cid {
>>>+		unsigned int manfid;
>>>+		char prod_name[8];
>>>+		unsigned char hwrev;
>>>+		unsigned char fwrev;
>>>+	} broken_cards[] = {
>>>+		{ 0x00150000, "\x30\x30\x30\x30\x30\x30\x15\x00", 0x06, 0x03 },
>>>+	};
>>>+
>>>+	for (i = 0; i < sizeof(broken_cards)/sizeof(broken_cards[0]); i++) {
>>>+		const struct broken_card_cid *b = broken_cards + i;
>>>+
>>>+		if (b->manfid != c->manfid)
>>>+			continue;
>>>+		if (memcmp(b->prod_name, c->prod_name, sizeof(b->prod_name)) != 0)
>>>+			continue;
>>>+		if (b->hwrev != c->hwrev || b->fwrev != c->fwrev)
>>>+			continue;
>>>+		return 1;
>>>+	}
>>>+	return 0;
>>>+}
>>
>>I've already mentioned this to the OMAP folk... What problem is this
>>trying to work around?  If it's a card problem, it's at the wrong
>>level.  If it's a problem with the host not waiting the mandatory
>>80 cycles before starting a command, that could be the upper layers
>>or a host problem.
>>
>>Either way, the right place to fix this is _not_ in the request
>>function but in the set_ios function.  The request function does
>>not know if the card has just been powered up.
> 
> 
> Anderson, can you pull out the broken card check from omap.c, and put
> it into a separate patch? Let's fix the omap.c issues first, and have
> that integrated. Then we can start working on the additional patches
> and test them one at a time.
> 

Ok. It's already done. I'll wait the omap clock framework fix to post another patch for
omap.c, ok?

Regards,

Anderson Briglia
INdT - Manaus - Brazil
