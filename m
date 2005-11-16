Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVKPBtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVKPBtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbVKPBtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:49:04 -0500
Received: from ns2.suse.de ([195.135.220.15]:45024 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965156AbVKPBtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:49:03 -0500
From: Andi Kleen <ak@suse.de>
To: nagar@watson.ibm.com
Subject: Re: [Patch 1/4] Delay accounting: Initialization
Date: Wed, 16 Nov 2005 02:50:22 +0100
User-Agent: KMail/1.8.2
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43796596.2010908@watson.ibm.com> <17274.34333.348600.111728@wombat.chubb.wattle.id.au> <437A8FED.3080508@watson.ibm.com>
In-Reply-To: <437A8FED.3080508@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160250.23213.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 02:48, Shailabh Nagar wrote:

> 
> Are there problems with using sched_clock()for timestamping if one is prepared
> to live with them not necessarily being nanosecond accurate ? I'm trying to search
> the archives etc. but if you can respond with any quick comments, that'd be very
> helpful.

First it can be relatively slow on P4s (hundreds of cycles) 

On other systems it can run with different frequencies on different CPUs,
so you never need to assume a timestamp from one CPU is comparable with
the one from other CPUs (the scheduler carefully avoids this)

If you need a stable timestamp over multiple CPUs don't use it.

In general do_gettimeofday is much safer.
do_gettimeofday shouldn't be that much slower for the case where TSC
works, and where it doesn't there is no other alternative.

-Andi
