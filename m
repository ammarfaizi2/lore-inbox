Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTIXAVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTIXAUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:20:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30943 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261219AbTIXATg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:19:36 -0400
Date: Tue, 23 Sep 2003 17:06:34 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: akpm@osdl.org, willy@debian.org, schwab@suse.de, bcrl@kvack.org,
       tony.luck@intel.com, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       peter@chubb.wattle.id.au, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923170634.14bf166d.davem@redhat.com>
In-Reply-To: <20030924001456.GI13172@parcelfarce.linux.theplanet.co.uk>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<jehe3372th.fsf@sykes.suse.de>
	<20030923115200.1f5b44df.davem@redhat.com>
	<20030923192804.GG13172@parcelfarce.linux.theplanet.co.uk>
	<20030923122200.258215a3.davem@redhat.com>
	<20030923161529.5203ce4d.akpm@osdl.org>
	<20030923163744.4b9bb4c7.davem@redhat.com>
	<20030924001456.GI13172@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003 01:14:56 +0100
Matthew Wilcox <willy@debian.org> wrote:

> (I can see this descending into get_unaligned_likely() and
> get_aligned_unlikely() which i'd rather avoid ...)

get_unaligned_unlikely() is exactly what just loading the 32-bit value
as if it were aligned is, ie. what we're doing right now.

People who want top performance should not put a networking card into
their machine that can only DMA packets to 32-byte or whatever
boundaries.  That's exactly the limitation NS83820 has and therefore
why it should be avoided like the plague by performance conscious
folks.
