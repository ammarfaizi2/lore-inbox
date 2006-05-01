Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWEATAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWEATAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWEATAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:00:13 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:47015 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932072AbWEATAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:00:11 -0400
X-IronPort-AV: i="4.04,169,1144047600"; 
   d="scan'208"; a="1800283159:sNHT31743354"
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
X-Message-Flag: Warning: May contain useful information
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	<ada3bftvatf.fsf@cisco.com>
	<1146509646.20760.63.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 12:00:00 -0700
In-Reply-To: <1146509646.20760.63.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon, 01 May 2006 20:54:06 +0200")
Message-ID: <aday7xltvtb.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 19:00:10.0637 (UTC) FILETIME=[78660BD0:01C66D51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arjan> do you really NEED the vaddr?  (most of the time linux
    Arjan> drivers don't need it, while other OSes do) If you really
    Arjan> need it you should grab it at dma_map time ...  (and
    Arjan> realize that it's not kernel addressable per se ;)

Yes, they need some kind of vaddr.

It's kind of a layering problem.  The IB stack assumes that IB devices
have a DMA engine that deals with bus addresses.  But the ipath driver
has to simulate this by using a memcpy on the CPU to move data to the
PCI device.

I really don't know what the right solution is.  Maybe having some way
to override the dma mapping operations so that the ipath driver can
keep the info it needs?

 - R.
