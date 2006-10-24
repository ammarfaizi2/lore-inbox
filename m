Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWJXKTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWJXKTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWJXKTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:19:04 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:61571 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S965126AbWJXKTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:19:03 -0400
Date: Tue, 24 Oct 2006 13:14:58 +0300
From: Timo Teras <timo.teras@solidboot.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Timo Teras <timo.teras@solidboot.com>, linux-kernel@vger.kernel.org
Subject: Re: MMC: When rescanning cards check existing cards after mmc_setup()
Message-ID: <20061024101458.GA17024@mail.solidboot.com>
References: <20061016090609.GB17596@mail.solidboot.com> <453B4005.8080501@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453B4005.8080501@drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 11:55:17AM +0200, Pierre Ossman wrote:
> Timo Teras wrote:
> > Some broken cards seem to process CMD1 even in stand-by state. The result is
> > that the card replies with ILLEGAL_COMMAND error for the next command sent
> > after rescanning. Currently the next command is select card, which would
> > return the error. But the CMD7 does actually succeed and retries of the
> > command will timeout. The solution is to poll card status after the CMD1
> > which clears the cached error.
>
> I take it these cards do not reply to CMD2?

No. It just caches the error and fails the next command sent.

> This change is ok right now, but might come back to bite us in the
> future if we implement more intelligent voltage selection (right now new
> cards will have to make due with what's already selected).

I see. The voltage selection is done in mmc_setup() based on what cards are
present.

> If we check cards on both sides of mmc_setup(), then we should be covered.

Should I update my patch to do this already? Or is the code fine as is?

> Also, please add some comments about why we do this. Otherwise it will
> run the risk of getting removed in the future.

Will do.

I'll send updated patch later on.

-- Timo

