Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWB0PdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWB0PdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWB0Pcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:32:41 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:20166 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S964775AbWB0PcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:32:16 -0500
Subject: [Patch 0/4] Reordering of functions, try 2
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: akpm@osdl.org, ak@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Feb 2006 16:23:45 +0100
Message-Id: <1141053825.2992.125.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


This is the second posting of the function reorder patches.
I've run a series of lmbench (3.0) runs on the patches earlier today on
this set, with the following results (I'll discuss 2 runs, one with the
first 3 patches, and one with all patches)


These are descriptions of the results, since the full lmbench run is a
LOT of numbers; this is the summary of it

1) There is a whole class of tests where it just doesn't matter at all.
In this class are the cpu measurements of FPU ops/second but also the
RAM bandwidth tests and the like. This is fully understandable; these
tests go straight from userspace->hardware, kernel changes don't impact
these.

2) In the "processor/processes" group, 7 tests changed behavior, and the
average of these changes was a performance increase by 10% (!!). The
exception was the signal handling test, which decreased by 6%. This
actually made me feel good, since the original function list was based
on a profile run that didn't do signals much if at all.

The second run (with all 4 patches) showed some fluctuations here but on
average it was in the noise region. Exception to this was the stat test,
which lost half the gain from the first 3 patches. Here also the signals
test lost

3) In the latency group, the 3-patches run is again in the 10% gain
range. Here the 4-patches run shows an additional gain for several of
the tests in the 5% range and for example the af_unix test showed a loss
compared to the 3-patches run



