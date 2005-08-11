Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVHKKyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVHKKyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVHKKyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:54:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:11962 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964988AbVHKKyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:54:15 -0400
Date: Thu, 11 Aug 2005 12:54:10 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386 boottime for_each_cpu broken
Message-ID: <20050811105409.GI8974@wotan.suse.de>
References: <Pine.LNX.4.61.0508102220070.16483@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508102220070.16483@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:59:28PM -0600, Zwane Mwaikambo wrote:
> for_each_cpu walks through all processors in cpu_possible_map, which is 
> defined as cpu_callout_map on i386 and isn't initialised until all 
> processors have been booted. This breaks things which do for_each_cpu 
> iterations early during boot. So, define cpu_possible_map as a bitmap with 
> NR_CPUS bits populated. This was triggered by a patch i'm working on which 
> does alloc_percpu before bringing up secondary processors.

Better is to initialize it in mpparse.c. That is what x86-64 is doing now.

-Andi
