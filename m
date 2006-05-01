Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWEASuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWEASuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEASuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:50:39 -0400
Received: from test-iport-1.cisco.com ([171.71.176.117]:48182 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751221AbWEASui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:50:38 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
X-Message-Flag: Warning: May contain useful information
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 11:50:36 -0700
In-Reply-To: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Mon, 24 Apr 2006 14:23:01 -0700")
Message-ID: <ada3bftvatf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 18:50:38.0028 (UTC) FILETIME=[2318D8C0:01C66D50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Move away from an obsolete, unportable routine for
    Bryan> translating physical addresses.

This change:

 > -		isge->vaddr = bus_to_virt(sge->addr);
 > +		isge->vaddr = phys_to_virt(sge->addr);

is really wrong.  bus_to_virt() is really what you want, because in
this case the address is a bus address that came from dma_map_xxx().
You're still going to be hosed on systems with IOMMUs for example.

 - R.
