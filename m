Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422916AbWJOWqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422916AbWJOWqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWJOWqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:46:14 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:29611 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932175AbWJOWqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:46:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=PjRQvZWDt3qVueoXZA3FDNTiAurMPEAEJaR8DIkDwljqPkBCT5zIP04o5p0AoY/Gb3KHsD4fniXyrtSeirFwxLEcgQDemdsq03z9SNDp1NELM/LCbGEhKPtzCDaiGaYugrvOz9REBhTGKUDbcx6CMml2e4k9zIXhMH2ZFZOHP1w=  ;
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Date: Sun, 15 Oct 2006 15:45:58 -0700
User-Agent: KMail/1.7.1
Cc: alan@lxorguk.ukuu.org.uk, matthew@wil.cx, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
References: <1160161519800-git-send-email-matthew@wil.cx> <20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061015123432.4c6b7f15.akpm@osdl.org>
In-Reply-To: <20061015123432.4c6b7f15.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610151545.59477.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Most drivers should be able to say "enable MWI if possible, but
> > don't worry if it's not possible".  Only a few controllers need
> > additional setup to make MWI actually work ... if they couldn't
> > do that setup, that'd be worth a warning before they backed off
> > to run in a non-MWI mode.
> > 
> 
> So the semantics of pci_set_mwi() are "try to set MWI if this
> platform/device supports it".

Not what I said ... that's what the _driver_ usually wants to do,
which is different from the step implemented by set_mwi(). 


What Alan Cox said is a better paraphrase:

> MWI is an "extra cheese" option not a "no pizza" case

Or "sorry, that car is not available in olive, just burgundy."


Not:

> In that case its interface is misdesigned, because it doesn't discriminate
> between "yes-it-does/no-it-doesn't" (which we don't want to report, because
> either is expected and legitimate) and "something screwed up", which we do
> want to report, because it is always unexpected.

You mis-understand.  It's completely legit for the driver not to care.

I agree that set_mwo() should set MWI if possible, and fail cleanly
if it couldn't (for whatever reason).  Thing is, choosing to treat
that as an error must be the _driver's_ choice ... it'd be wrong to force
that policy into the _interface_ by forcing must_check etc.

- Dave


