Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbUDFXEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUDFXEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:04:41 -0400
Received: from ns.suse.de ([195.135.220.2]:37018 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263905AbUDFXEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:04:36 -0400
To: Evan Felix <evan.felix@pnl.gov>
Cc: linux-raid <linux-raid@vger.kernel.org>, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: [PATCH] Linux Raid5/6 abover 2 Terabytes
References: <1081285240.2219.43.camel@e-linux>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..The TENSION mounts as I MASSAGE your RIGHT ANKLE according to
 ancient Tibetan ACCOUNTING PROCEDURES..are you NEUROTIC yet??
Date: Wed, 07 Apr 2004 01:02:03 +0200
In-Reply-To: <1081285240.2219.43.camel@e-linux> (Evan Felix's message of
 "Tue, 06 Apr 2004 14:00:40 -0700")
Message-ID: <jey8p8ww0k.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evan Felix <evan.felix@pnl.gov> writes:

> Here is a patch that fixes a major issue in the raid5/6 code.  It seems
> that the code:
>
> logical_sector = bi->bi_sector & ~(STRIPE_SECTORS-1);
> (sector_t)     = (sector_t)    & (constant)
>
> that the right side of the & does not get extended correctly when the
> constant is promoted to the sector_t type.  I have CONFIG_LBD turned on
> so sector_t should be 64bits wide.  This fails to properly mask the
> value of 4294967296 (2TB/512) to 4294967296.  in my case it was coming
> out 0.  this cause the loop following this code to read from 0 to
> 4294967296 blocks so it could write one character.
>
> As you might imagine this makes a format of a 3.5TB filesystem take a
> very long time.
>
> Here is the patch:

Alternatively replace ~(STRIPE_SECTORS-1) by -STRIPE_SECTORS, which
doesn't need a cast.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
