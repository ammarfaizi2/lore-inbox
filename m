Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266647AbRGEHgA>; Thu, 5 Jul 2001 03:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266646AbRGEHfl>; Thu, 5 Jul 2001 03:35:41 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:41741 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266643AbRGEHff>; Thu, 5 Jul 2001 03:35:35 -0400
Date: Thu, 5 Jul 2001 03:35:31 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mike@bigstorage.com>, <kevin@bigstorage.com>, <linux-lvm@sistina.com>
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <20010705083402.D11805@vestdata.no>
Message-ID: <Pine.LNX.4.33.0107050310570.1063-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001, Ragnar Kjørstad wrote:

> What do you mean?
> Is it not feasible to fix this in LVM as well, or do you just not know
> what needs to be done to LVM?

Fixing LVM is not on the radar of my priorities.  The code is sorely in
need of a rewrite and violates several of the basic planning tenents that
any good code in the block layer should follow.  Namely, it should have 1)
planned on supporting 64 bit offsets, 2) never used multiplication,
division or modulus on block numbers, and 3) don't allocate memory
structures that are indexed by block numbers.  LVM failed on all three of
these -- and this si just what I noticed in a quick 5 minute glance
through the code.  Sorry, but LVM is obsolete by design.  It will continue
to work on 32 bit block devices, but if you try to use it beyond that, it
will fail.  That said, we'll have to make sure these failures are graceful
and occur prior to the user having a chance at loosing any data.

Now, thankfully there are alternatives like ELVM, which are working on
getting the details right from the lessons learned.  Given that, I think
we'll be in good shape during the 2.5 cycle.

		-ben

