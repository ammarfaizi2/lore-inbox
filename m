Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUCZAY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUCZAXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:23:55 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:17680 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263824AbUCZAEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:04:43 -0500
Date: Thu, 25 Mar 2004 17:03:52 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Lars Marowsky-Bree <lmb@suse.de>, Kevin Corry <kevcorry@us.ibm.com>,
       linux-kernel@vger.kernel.org
cc: Jeff Garzik <jgarzik@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <1041730000.1080259431@aslan.btc.adaptec.com>
In-Reply-To: <20040325234452.GC15264@marowsky-bree.de>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <1019470000.1080255540@aslan.btc.adaptec.com> <20040325234452.GC15264@marowsky-bree.de>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uhm. DM sort of does (at least where the morphing amounts to resyncing a
> part of the stripe, ie adding a new mirror, RAID1->4, RAID5->6 etc).
> Freeze, load new mapping, continue.

The point is that these trivial "morphings" can be achieved with limited
effort regardless of whether you do it via EMD or DM.   Implementing this
in EMD could be achieved with perhaps 8 hours work with no significant
increase in code size or complexity.  This is part of why I find them
"uninteresting".  If we really want to talk about generic morphing,
I think you'll find that DM is no better suited to this task than MD or
its derivatives.

> I agree that more complex morphings (RAID1->RAID5 or vice-versa in
> particular) are more difficult to get right, but are not that often
> needed online - or if they are, typically such scenarios will have
> enough temporary storage to create the new target, RAID1 over,
> disconnect the old part and free it, which will work just fine with DM.

The most common requests that we hear from customers are:

o single -> R1

	Equally possible with MD or DM assuming your singles are
	accessed via a volume manager.  Without that support the
	user will have to dismount and remount storage.

o R1 -> R10

	This should require just double the number of active members.
	This is not possible today with either DM or MD.  Only
	"migration" is possible.

o R1 -> R5
o R5 -> R1

	These typically occur when data access patterns change for
	the customer.  Again not possible with DM or MD today.

All of these are important to some subset of customers and are, to
my mind, required if you want to claim even basic morphing capability.
If you are allowing the "cop-out" of using a volume manager to substitute
data-migration for true morphing, then MD is almost as well suited to
that task as DM.

--
Justin

