Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWD1IjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWD1IjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWD1IjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:39:06 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:5962 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030369AbWD1IjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:39:05 -0400
Date: Fri, 28 Apr 2006 10:39:03 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
Message-ID: <20060428083903.GA11819@osiris.boeblingen.de.ibm.com>
References: <20060424150544.GL15613@skybase> <20060428073358.GA15166@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428073358.GA15166@filer.fsl.cs.sunysb.edu>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 04:33:58AM -0400, Josef Sipek wrote:
> On Mon, Apr 24, 2006 at 05:05:44PM +0200, Martin Schwidefsky wrote:
> > +++ linux-2.6-patched/drivers/s390/s390mach.c	2006-04-24 16:47:28.000000000 +0200
> ...
> > +#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */
> 
> I'm no s390 expert, but shouldn't the above use something like HZ?

Using HZ here feels just wrong to me. MAX_IPD_TIME has nothing to do with the
timer frequency. In this case it's used to tell if there were 30 machine
checks within the last 5 minutes (in a usec granularity). It's just by
accident that this could be expressed using HZ.
(5 * 60 * USEC_PER_SEC) would probably look better...
