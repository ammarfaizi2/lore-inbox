Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTFPVlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTFPVlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:41:09 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:31736 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264368AbTFPVlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:41:06 -0400
Date: Mon, 16 Jun 2003 15:55:07 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Robert White <rwhite@casabyte.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: continuous backtrace ... ?
Message-ID: <20030616155507.L26944@schatzie.adilger.int>
Mail-Followup-To: Robert White <rwhite@casabyte.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <PEEPIDHAKMCGHDBJLHKGCEPICPAA.rwhite@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGCEPICPAA.rwhite@casabyte.com>; from rwhite@casabyte.com on Mon, Jun 16, 2003 at 12:15:41PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2003  12:15 -0700, Robert White wrote:
> I have a 2.5.70 kernel image which, at boot, goes into a continuously
> looping backtrace.  It scrolls up the screen too fast and continuously to
> read but it is clearly a backtrace. If I just relax and watch I can see the
> [bracketed hex] and routine name shape of it whizzing by.
> 
> This happens while the file systems are read only and the system doesn't
> respond to the keyboard at all.
> 
> Is there any good way to capture this stream of data in any kind of useful
> way?  or at least pause the spew so that I can find the general locus of the
> problem?
> 
> Given the immediacy of the problem (it appears just-about-concurrently with
> attempt to draw the boot logo) I suspect that it has something to do with
> the console driver (radeon frame buffer VGA console in normal mode)
> interacting with my All-In-Wonder 9700 pro and the very new P4-3ghz in
> hyperthreading mode.

Probably a stack overflow.  Once you hit the do_IRQ() stack overflow
detection code, you get stuck in a loop because your console output is
slow enough that you immediately get another IRQ, rinse, repeat.

I fixed this locally by adding a static jiffies counter to rate-limit
the overflow stack dump to once per 5 seconds.  If you overflow your
stack more often than that, well too bad.  At least you have a chance
to look at your console instead of the machine essentially being wedged.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

