Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUFBVDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUFBVDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbUFBVDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:03:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62865 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264153AbUFBVDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:03:11 -0400
Date: Wed, 2 Jun 2004 23:04:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] exec-shield patch for 2.6.7-rc2-bk2, integrated with NX
Message-ID: <20040602210421.GA22011@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the latest exec-shield patch for 2.6.7-rc2-bk2, integrated with
the 'NX' feature (see the announcement from earlier today):

  http://redhat.com/~mingo/exec-shield/exec-shield-on-nx-2.6.7-rc2-bk2-A7

you first have to apply the NX patch, which can be found at:

  http://redhat.com/~mingo/nx-patches/nx-2.6.7-rc2-bk2-AE

prebuild kernel RPMs for Fedora Core 2, with this latest version of
exec-shield, are available at:

    http://redhat.com/~arjanv/2.6/RPMS.kernel/

(kernel-2.6.6-1.411 has this latest, NX-aware exec-shield.)

if the CPU supports NX (and the kernel has been compiled with
CONFIG_HIGHMEM64G) then exec-shield will use NX to provide page-level
finegrained control over execution. On legacy CPUs that dont support NX
the segment-limit method is used to control execution (in a coarser
way). In the NX case the segment-limit is turned off altogether.

e.g. on an Athlon64 box the boot message looks:

  NX (Execute Disable) protection: active

on a CPU without NX the boot message is:

  NX (Execute Disable) protection: not present!
  Using x86 segment limits to approximate NX protection

note: the NX patch will also protect against kernel-space code
injection.

all the other components of exec-shield are identical between NX and
non-NX: the brk area is non-executable, libraries and PIE binaries are
moved into the ascii-shield as much as possible, and all aspects of the
address space are randomized.

	Ingo
