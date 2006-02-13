Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWBMQNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWBMQNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWBMQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:13:18 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:45252 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750816AbWBMQNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:13:16 -0500
Date: Mon, 13 Feb 2006 17:13:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060213161303.GA9315@osiris.boeblingen.de.ibm.com>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213104645.GA17173@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213104645.GA17173@elte.hu>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The boot sequence on s390 sometimes takes ages and we spend a very 
> > long time (up to one or two minutes) in calibrate_migration_costs. The 
> > time spent there differs from boot to boot. Also the calculated costs 
> > differ a lot. I've seen differences by up to a factor of 15 (yes, 
> > factor not percent). Also I doubt that making these measurements make 
> > much sense on a completely virtualized architecture where you cannot 
> > tell how much cpu time you will get anyway. Is there any workaround or 
> > fix available so we can avoid seeing this?
> 
> which is the precise kernel version used? We toned down calibration a 
> bit recently.

2.6.16-rc3.

> The immediate workaround would be to use the migration_cost=0 boot 
> parameter.
> 
> Generally, i agree that it makes sense to not calibrate at all on 
> virtual platforms. Does the patch below help?  It gives virtual 
> platforms a way to provide a default migration cost and thus avoid the 
> boot-time calibration altogether. (I have tested it on x86, it does the 
> expected thing.) This needs to hit v2.6.16 too.

Yes, calibrate_migration_costs is very fast now. But it turned out that
this was just hiding the real problem: if we have CONFIG_PREEMPT disabled
the kernel gets (sometimes) unbelievably slow.
I think this happened somewhere between rc1 and rc3. Maybe Hannes knows
more exactly when this happened the first time, since I always run with
CONFIG_PREEMPT enabled.

Heiko
