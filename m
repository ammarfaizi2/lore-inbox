Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbUKPQjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbUKPQjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUKPQgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:36:32 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:47326 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262020AbUKPQgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:36:04 -0500
Date: Tue, 16 Nov 2004 17:25:54 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2
Message-ID: <20041116162553.GA32470@bogon.ms20.nix>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Nov 14, 2004 at 06:49:04PM -0800, Linus Torvalds wrote:
> 
> Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should 
> now calm down, so I do not want to see anything but bug-fixes until 2.6.10 
> is released. Otherwise we'll never get there.
here's a simple compile fix necessary due to dev.power changes:

--- linux-2.6.10-rc2/drivers/macintosh/mediabay.c.orig	2004-11-16 17:13:53.165493040 +0100
+++ linux-2.6.10-rc2/drivers/macintosh/mediabay.c	2004-11-16 17:16:13.587145704 +0100
@@ -713,13 +713,13 @@
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power.power_state && state >= 2) {
 		down(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
 		up(&bay->lock);
 		msleep(MB_POLL_DELAY);
-		mdev->ofdev.dev.power_state = state;
+		mdev->ofdev.dev.power.power_state = state;
 	}
 	return 0;
 }
@@ -728,8 +728,8 @@
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (mdev->ofdev.dev.power_state != 0) {
-		mdev->ofdev.dev.power_state = 0;
+	if (mdev->ofdev.dev.power.power_state != 0) {
+		mdev->ofdev.dev.power.power_state = 0;
 
 	       	/* We re-enable the bay using it's previous content
 	       	   only if it did not change. Note those bozo timings,

Signed-off-by: Guido Guenther <agx@sigxpcu.org>
Cheers,
 -- Guido
