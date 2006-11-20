Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934014AbWKTIu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934014AbWKTIu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934015AbWKTIu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:50:26 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:26605 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S934013AbWKTIuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:50:25 -0500
Date: Mon, 20 Nov 2006 09:49:06 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Alasdair G Kergon <agk@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Andrew Morton <akpm@osdl.org>,
       Neil Brown <neilb@suse.de>
Subject: Re: 2.6.19-rc6 -- dm: possible recursive locking detected
Message-ID: <20061120084906.GB17447@osiris.boeblingen.de.ibm.com>
References: <20061117153003.GB7131@osiris.boeblingen.de.ibm.com> <20061117194303.GB4409@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117194303.GB4409@agk.surrey.redhat.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 07:43:03PM +0000, Alasdair G Kergon wrote:
> On Fri, Nov 17, 2006 at 04:30:03PM +0100, Heiko Carstens wrote:
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > 2.6.19-rc6-g1b9bb3c1 #28
> > ---------------------------------------------
> > kpartx/945 is trying to acquire lock:
> >  (&md->io_lock){----}, at: [<00000000001f8faa>] dm_request+0x42/0x24c
> > 
> > but task is already holding lock:
> >  (&md->io_lock){----}, at: [<00000000001f8faa>] dm_request+0x42/0x24c
> 
> Known problem - nobody's written a patch to fix it yet to my knowledge,
> but I don't recall any reports of real world lock-ups related to this - just
> several reports of the debug warning messages:-)
> 
> Simply ignore the message for now - or submit a patch that fixes the
> underlying problem:-)

Ignoring would be good, but this problem renders lockdep useless since it
stops working after it found the first possible bug.

While we are at it:

this one is sitting since ages in -mm and probably waiting for your approval:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/md-dm-reduce-stack-usage-with-stacked-block-devices.patch
