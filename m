Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVD2Sbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVD2Sbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVD2Sbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:31:39 -0400
Received: from groover.houseafrika.com ([12.162.17.52]:5475 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262874AbVD2Sbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:31:36 -0400
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Caitlin Bestler <caitlin.bestler@gmail.com>,
       Bill Jordan <woodennickel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, David Addison <addy@quadrics.com>
Subject: Re: RDMA memory registration
X-Message-Flag: Warning: May contain useful information
References: <20050425135401.65376ce0.akpm@osdl.org>
	<20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com>
	<20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	<20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
	<426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org>
	<5ebee0d105042907265ff58a73@mail.gmail.com>
	<469958e005042908566f177b50@mail.gmail.com>
	<52d5sdjzup.fsf_-_@topspin.com> <42727B60.7010507@ens-lyon.org>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 29 Apr 2005 11:31:35 -0700
In-Reply-To: <42727B60.7010507@ens-lyon.org> (Brice Goglin's message of
 "Fri, 29 Apr 2005 20:22:24 +0200")
Message-ID: <52y8b1ige0.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Apr 2005 18:31:35.0739 (UTC) FILETIME=[ACA320B0:01C54CE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Brice> Do you plan to work with David Addison from Quadrics ?  For
    Brice> sure, your hardware have very different capabilities.  But
    Brice> ioproc_ops is a really nice solution and might help a lot
    Brice> when dealing with deregistration and fork.

I'm following the discussion with interest.  Some hardware (eg
Mellanox HCAs) has the ability to use these hooks to avoid pinning
pages at all, but in general IB and iWARP need to pin pages so the
mapping doesn't change.

    Brice> For instance, instead of adding PROT_DONT/ALWAYSCOPY, you
    Brice> may use an ioproc hook in the fork path. This hook (a
    Brice> function in your driver) would be called for each
    Brice> registered page. It will decide whether the page should be
    Brice> pre-copied or not and update the registration table (or
    Brice> whatever stores address translations in the NIC).  In
    Brice> addition, the driver would probably pre-copy cow pages when
    Brice> registering them.

This sort of monkeying around with the VM from driver code seems much
more complicated than letting userspace handle it.

 - R.
