Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbTEOVQC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTEOVQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:16:02 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:35570
	"EHLO flat") by vger.kernel.org with ESMTP id S264098AbTEOVQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:16:01 -0400
Date: Thu, 15 May 2003 22:29:45 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: O(1) scheduler questions + bug
Message-ID: <20030515212945.GA617@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

I started writing this email a while ago, the Doom III trailer example/bug has
prompted me to finish it.

Firstly, in -mm MAX_SLEEP_AVG defaults to 10 seconds. This means that a new
interactive task has a relatively low priority for nearly 5 seconds which feels
too long in practise. (eg start ogg123, music starts, switch desktop, music
skips) I think that MAX_SLEEP_AVG should be reduced to allow the scheduler to
react quicker.

Secondly, if there are (hypothetically) two interactive tasks, one repeatedly
works for 10ms and then sleeps for 90ms, and the other works for 45ms and
sleeps for 55ms, then they get the same maximum priority even though one is
"more interactive" than the other (using 10% of CPU rather than 45%). 

Has this been considered in the design of the effective_prio function? Does it
matter?

Finally, playing the Doom III trailer with mplayer results in mplayer's
priority slowly increasing to the maximum and therefore becoming
non-interactive, which means a CPU hog (perl -e 'while (1) {}') can cause the
audio/video playback to skip.  Mplayer consumes about 25% of CPU, X consumes
about 10%. (measured with top)

I'm currently using 2.5.69-mm2, Celeron 333, pre-empt.

Charlie
