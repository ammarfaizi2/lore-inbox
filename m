Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbUKQCMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUKQCMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUKQCLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:11:10 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:34710 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262158AbUKQBuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:50:44 -0500
Date: Tue, 16 Nov 2004 17:50:42 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [patch] prefer TSC over PM Timer
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Pallipadi, Venkatesh wrote:

> I think trying to remove repeated inl()'s in read_pmtmr is a better 
> fix for this issue. As John mentioned in other thread, we should do 
> repeated reads only when something looks broken. Not always.

that would be a nice improvement... then timer_pm will only be 3x as slow 
as timer_tsc instead of 10x slower :)  it's still a lot of unnecessary 
overhead for many systems, and unfortunately this is a real performance 
problem (albeit exaggerated by code which is overzealous in its use of 
gettimeofday()).

on a tangent... has the local apic timer ever been considered?  it's fixed 
rate, and my measurements show it in the same performance ballpark as TSC.

i know that all p3, p-m, p4, k8 and efficeon have local APIC, but i'm not 
sure if k7 (other than k7 smp parts of course) have local apics... so i'm 
not sure how widespread it is compared to pm-timer.

wouldn't local apic timer be a lot better for NUMA too?

hey wait, what exactly is the problem with TSC on NUMA?  don't you just 
need some per-cpu data (epoch and calibration) to make it work?

-dean
