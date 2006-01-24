Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWAXJcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWAXJcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWAXJcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:32:09 -0500
Received: from cantor.suse.de ([195.135.220.2]:48830 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030221AbWAXJcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:32:08 -0500
From: Neil Brown <neilb@suse.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Tue, 24 Jan 2006 20:32:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17365.62482.462589.875480@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 7] md: Introduction - raid5 reshape mark-2
In-Reply-To: message from Lars Marowsky-Bree on Tuesday January 24
References: <20060124112626.4447.patches@notabene>
	<20060124092303.GD22870@marowsky-bree.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 24, lmb@suse.de wrote:
> On 2006-01-24T11:40:47, NeilBrown <neilb@suse.de> wrote:
> 
> > I am expecting that I will ultimately support online conversion of
> > raid5 to raid6 with only one extra device.  This process is not
> > (efficiently) checkpointable and so will be at-your-risk.
> 
> So the best way to go about that, if one wants to keep that option open
> w/o that risk, would be to not create a raid5 in the first place, but a
> raid6 with one disk missing?
> 
> Maybe even have mdadm default to that - as long as just one parity disk
> is missing, no slowdown should happen, right?

Not exactly....

raid6 has rotating parity drives, for both P and Q (the two different
'parity' blocks).
With one missing device, some Ps, some Qs, and some data would be
missing, and you would definitely get a slowdown trying to generate
some of it.

We could define a raid6 layout that didn't rotate Q.  Then you would
be able to do what you suggest.
However it would then be no different from creating a normal raid5 and
supporting online conversion from raid5 to raid6-with-non-rotating-Q.
This conversion doesn't need an reshaping pass, just a recovery of the
now-missing device.

raid6-with-non-rotating-Q would have similar issues to raid4 - one
drive becomes a hot-spot for writes.  I don't know how much of an
issue this really is though.

NeilBrown
