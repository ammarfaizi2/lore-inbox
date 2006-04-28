Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWD1JYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWD1JYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWD1JYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:24:41 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:4100 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030335AbWD1JYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:24:40 -0400
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20060428083903.GA11819@osiris.boeblingen.de.ibm.com>
References: <20060424150544.GL15613@skybase>
	 <20060428073358.GA15166@filer.fsl.cs.sunysb.edu>
	 <20060428083903.GA11819@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 28 Apr 2006 11:24:44 +0200
Message-Id: <1146216285.5138.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 10:39 +0200, Heiko Carstens wrote:
> > > +++ linux-2.6-patched/drivers/s390/s390mach.c	2006-04-24 16:47:28.000000000 +0200
> > ...
> > > +#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */
> > 
> > I'm no s390 expert, but shouldn't the above use something like HZ?
> 
> Using HZ here feels just wrong to me. MAX_IPD_TIME has nothing to do with the
> timer frequency. In this case it's used to tell if there were 30 machine
> checks within the last 5 minutes (in a usec granularity). It's just by
> accident that this could be expressed using HZ.
> (5 * 60 * USEC_PER_SEC) would probably look better...

Using HZ would be wrong. The check that uses MAX_IPD_TIME compares it
against the result of a get_clock() call. That uses the TOD Clock
directly, there is no dependency on HZ.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


