Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWHERZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWHERZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWHERZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 13:25:07 -0400
Received: from main.gmane.org ([80.91.229.2]:59271 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030278AbWHERZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 13:25:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: e100: checksum mismatch on 82551ER rev10
Followup-To: gmane.linux.network
Date: Sat, 5 Aug 2006 17:21:57 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <eb2k3k$qnd$1@sea.gmane.org>
References: <44D0D7CA.2060001@intel.com> <62b0912f0608040404p59545a0asc7f5fc5f537ec32c@mail.gmail.com> <20060804.042024.63108922.davem@davemloft.net> <20060804.042834.78730901.davem@davemloft.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-065-013-029-145.sip.asm.bellsouth.net
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@davemloft.net said:
> And BTW I want to remind the entire world that the last time Intel
> cried wolf to all of us about vendors using broken EEPROMs with their
> networking chips it turned out to be a bug in one of the patches Intel
> put into the Linux driver. :-)
>
> Intel should really humble themselves and help users instead of hinder
> them.  Putting the blame on other vendors does not help users, I don't
> care how you spin it.  It only serves to make Intel look like a bunch
> of control freaks, and that pisses off users to no end.

The real problem here is neither Intel nor users. It's crappy vendor
QA.  I recently had to deal with a batch of e1000 cards that had the
*wrong* EEPROMs, with *correct* checksums.

So of course the driver didn't complain - nevermind the fact that the
EEPROMs might claim you have a copper card when it's really fiber. And
that's best case, because it fails obviously. Far worse is when an
EEPROM is close enough to "work", but claim the wrong chipset revision
and cause the driver to do totally wrong things in strange
circumstances.

I think this is what Auke is worried about. If you can't trust the
EEPROM, all sorts of maddeningly subtle things can go wrong. And it
isn't likely to be properly diagnosed by an end user.

The sad thing is that the checksum can only protect against a subset of
EEPROM problems. But it does help. As a counterexample, a power failure
last weekend corrupted the EEPROM of the onboard e100 in one of my
servers, and this EEPROM check led to an immediate diagnosis of the
problem.

> Please put the option into the e100 driver to allow trying to use the
> device even if the EEPROM checksum is wrong.

There is already support for EEPROM read/write in ethtool. I used it to
fix the e1000 cards in question. If e100 implements ethtool -E, all
that's needed is documentation on where in the EEPROM the checksum is
stored and how to calculate it. I don't doubt the freely-available pdfs
for e100 chipsets cover this.

Jason

