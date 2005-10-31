Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVJaAJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVJaAJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJaAJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:09:08 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38572
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932409AbVJaAJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:09:07 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: echo 0 > /proc/sys/vm/swappiness triggers OOM killer under 2.6.14.
Date: Sun, 30 Oct 2005 18:09:04 -0600
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301809.04245.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.6.14 (UML), I have a workload that runs with 64 megs ram and 256 megs 
swap space.  It completes (albeit swapping like mad) with swappiness at the 
default 60, but if I set it to 0 the OOM killer kicks in and the script 
aborts.

The workload is basically compiling gcc 4.0.2 with gcc 3.3.2.  Now gcc a pig 
(hence the reason for feeding it 256 megs of swap space), but twiddling 
swappiness shouldn't make the difference between success and failure.

Why does the OOM killer ever trigger when there are _any_ dirty pages queued 
up for DMA to an existing local block device?  (Or when there is SWAP SPACE 
LEFT?)  This is memory that will be freed in time, thus the system isn't 
guaranteed to hang yet.  Don't we only need to trigger the OOM killer if the 
alternative is the system hanging?

Rob

P.S.  Not only is this repeatable, but I have a script that I run that 
downloads the UML and gcc sources, builds UML, and tries to build GCC under 
it.  I can put this up somewhere if anybody would like to try to reproduce 
this themselves...
