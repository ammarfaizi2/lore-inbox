Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbUKQQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbUKQQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUKQQhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:37:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60644 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262401AbUKQQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:35:03 -0500
Subject: RE: [patch] prefer TSC over PM Timer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
	 <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100705495.32698.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 15:31:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-17 at 01:50, dean gaudet wrote:
> on a tangent... has the local apic timer ever been considered?  it's fixed 
> rate, and my measurements show it in the same performance ballpark as TSC.
> 

It would certainly work for the SMP cases which are most of the "hard"
cases where TSC breaks. This seems to be a good path to me and although
C3 would fail as has been pointed out a C3 resume is sufficiently
expensive that fixing up the tsc offset on the resume from PMTMR isn't
going to kill anyone.

> hey wait, what exactly is the problem with TSC on NUMA?  don't you just 
> need some per-cpu data (epoch and calibration) to make it work?

You have unrelated clocks that drift over time. You can't just calibrate
them.
Its different to the BP6 for example where you at least know the CPU
clocks are fixed ratio. 
