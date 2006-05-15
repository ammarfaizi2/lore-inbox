Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWEOV2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWEOV2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWEOV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:28:50 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:4116 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964875AbWEOV2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:28:49 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="1806595731:sNHT61712736"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
X-Message-Flag: Warning: May contain useful information
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com>
	<adad5efuw1o.fsf@cisco.com>
	<1147728081.2773.25.camel@chalcedony.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 14:28:45 -0700
In-Reply-To: <1147728081.2773.25.camel@chalcedony.pathscale.com> (Bryan O'Sullivan's message of "Mon, 15 May 2006 14:21:21 -0700")
Message-ID: <adar72vrn8y.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 21:28:48.0215 (UTC) FILETIME=[8D78F670:01C67866]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> As Segher mentioned, bus_to_virt is unportable, so it's
    Bryan> definitely the wrong thing to use.

Yes, but at least it says what you're trying to do.  asm-powerpc's
io.h has this for phys_to_virt:

 *	This function does not handle bus mappings for DMA transfers. In
 *	almost all conceivable cases a device driver should not be using
 *	this function

so replacing bus_to_virt with that is not a step forward.

    Bryan> Any ideas?  Should this turn from a one-liner into a
    Bryan> big-refactor-for-2.6.18 patch?

I don't think there's a quick way to fix this.  What you really want
to do is override the DMA mapping functions for your device so that
you can keep track of the kernel mapping.  powerpc can already do this
(cf the ehca driver), and I think patches to do it on x86-64 are
floating around as part of the "Calgary IOMMU" work.

 - R.
