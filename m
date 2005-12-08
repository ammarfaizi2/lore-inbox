Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVLHVIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVLHVIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVLHVIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:08:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:10203 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932322AbVLHVIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:08:51 -0500
Date: Thu, 8 Dec 2005 22:08:50 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 1/3] Zone reclaim V3: main patch
Message-ID: <20051208210850.GS11190@wotan.suse.de>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Zone reclaim is enabled if the maximum distance to another node is higher
> than RECLAIM_DISTANCE, which may be defined by an arch. By default
> RECLAIM_DISTANCE is 20 meaning the distance to another node in the
> same component (enclosure or motherboard).

Sorry I made a mistake here earlier. On checking the ACPI spec
again it's valid to have distances < 20 (e.g. for a 1.5 NUMA factor
it would be legally 15) 

So better just check > LOCAL_DISTANCE, not >= 20.

Also a lot of Opteron BIOS get that wrong, but I'm adding some
sanity checking now so it should work in future.

-Andi
