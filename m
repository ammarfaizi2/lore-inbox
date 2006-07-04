Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWGDHCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWGDHCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWGDHCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:02:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:52666 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750874AbWGDHCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:02:39 -0400
From: Neil Brown <neilb@suse.de>
To: Avi Kivity <avi@argo.co.il>
Date: Tue, 4 Jul 2006 17:02:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17578.4725.914746.951778@cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
In-Reply-To: message from Avi Kivity on Tuesday July 4
References: <17577.43190.724583.146845@cse.unsw.edu.au>
	<44AA0612.10407@argo.co.il>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 4, avi@argo.co.il wrote:
> Neil Brown wrote:
> >
> > To my mind, the only thing you should put between the filesystem and
> > the raw devices is RAID (real-raid - not raid0 or linear).
> >
> I believe that implementing RAID in the filesystem has many benefits too:
>  - multiple RAID levels: store metadata in triple-mirror RAID 1, random 
> write intensive data in RAID 1, bulk data in RAID 5/6
>  - improved write throughput - since stripes can be variable size, any 
> large enough write fills a whole stripe

Maybe....

Now imagine what would be required to rebuild a whole drive onto a
spare after a drive failure.

I'm sure it is possible, and I believe ZFS does something like that.
I find it hard to imagine getting reasonable speed if there is much
complexity.  And the longer it takes, the longer your data is exposed
to multiple-failures.

There may well be room there to come up with a really clever idea that
makes it both flexible and fast....

Note that 'resync' wouldn't be a problem.  Having the filesystem know
about the raid means that resync (after unclean shutdown) can be quite
trivial (I believe there is a paper related to this at OLS this year).

NeilBrown
