Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUKMTvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUKMTvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 14:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUKMTvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 14:51:04 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:21229 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261161AbUKMTu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 14:50:57 -0500
Date: Sat, 13 Nov 2004 20:50:54 +0100 (MET)
From: =?ISO-8859-1?Q?Bo_Brant=E9n?= <bosse@acc.umu.se>
To: linux-kernel@vger.kernel.org
Subject: both better and worse interrupt latency with the "realtime" patces
Message-ID: <Pine.A41.4.61.0411132024400.58426@stalin.acc.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have measured the interrupt latency on a few different kernels.

The setup is a function generator connected to ACK on the printerport and 
an line added to the interrupt handler that toggles an data pin on it. 
Both signals is viewed on an oscilloscope with storage. (The computer was 
an old Athlon 800MHz but the results should be considered relative to each 
other)

Linux 2.4.27:
     most often 15us.
     often 10us or 15us
     time distribution decreases with time, didn't see any longer
     than 250us

Linux 2.6.9:
     most often 15us.
     else almost always 10us to 30us
     didn't see any longer than 75us
This is an improvement over the 2.4.x kernel

realtime-preempt-2.6.10-rc1-mm2-V0.7.1 by Ingo Molnar:
     often up to 50us
     every few seconds one interrupt takes 400us to 600us

MontaVistas 4 patces from 08 Oct againts Linux-2.6.9-rc3:
     most often 10us, 15us or 25us
     almost always below 30us
     but every few seconds an interrupt takes 600us.
Except for the sporadic long latency this patch would be the best, it 
collects almost all interrupts below 30us.

Bo Branten

