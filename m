Return-Path: <linux-kernel-owner+w=401wt.eu-S1761276AbWLHXi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761276AbWLHXi6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761277AbWLHXi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:38:58 -0500
Received: from qb-out-0506.google.com ([72.14.204.231]:44329 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761276AbWLHXi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:38:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NVbLa7cuv3VIpMzmgLni6gulwS0D27UUFyAIp7snhJdUNdjmCHmZoN02iZVwxRYlVDKUTMUFoJVUVVNmx2oEeCwIMO92vXPPb4aMLWotScw0AF0wqY93bf0rACIwHjHv+HgGs40DsX94045WvZLvnhJzp5U4QUDD1Ucz0wpekV0=
Message-ID: <9929d2390612081538w4fd8ab4j23b05ed30f48060a@mail.gmail.com>
Date: Fri, 8 Dec 2006 15:38:54 -0800
From: "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
To: "Auke Kok" <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH 2/6] e1000: use pcix_set_mmrbc
Cc: "Stephen Hemminger" <shemminger@osdl.org>,
       "Roland Dreier" <rdreier@cisco.com>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Cramer, Jeb J" <jeb.j.cramer@intel.com>
In-Reply-To: <4579EE04.9030409@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061208182241.786324000@osdl.org>
	 <20061208182500.478856000@osdl.org> <adalkli6p0e.fsf@cisco.com>
	 <20061208144332.33497a98@freekitty> <4579EE04.9030409@intel.com>
X-Google-Sender-Auth: 8e39124fbca16c1a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/06, Auke Kok <auke-jan.h.kok@intel.com> wrote:
> Stephen Hemminger wrote:
> > On Fri, 08 Dec 2006 13:45:05 -0800
> >
> > Hmm.. looks like all that code should really be moved off to PCI bus
> > quirk/setup.  None of it is E1000 specific.  Something like this (untested):
>
> This is not true, and I have to NAK the original patch. Part of the code Stephan is
> removing fixes a BUG in one of our *e1000 parts* that has the wrong size.
>
> It would be nice to fix generix pci-x issues qith quirks for platforms but the
> adjustment needs to stay for this specific e1000 case.
>
> Perhaps we can accomodate that specific case so that it is apparent from our code, as is
> not the case right now.
>
> Auke
>
> PS Thanks to Jeb for fishing this out ;)
>

Actually there are two issues that are being resolved with this function:
1- BIOS reports incorrect maximum memory read byte count (mmrbc).
This was seen on some older systems > 5 years ago.

2- EEPROM is reporting an incorrect mmrbc.

This function corrects both of these issues, Stephen second suggestion
of moving the BIOS fix to quirks.c is fine with me.  Even with the
code added to quirks.c, we still need this workaround as is to correct
for EEPROM's reporting 4k for a mmrbc.  So I am fine with Stephen's
second suggestion NAK the suggested change to e1000_hw.c

-- 
Cheers,
Jeff
