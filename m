Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUCHXdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUCHXdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:33:12 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:43960 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261224AbUCHXdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:33:11 -0500
Date: Tue, 9 Mar 2004 00:33:08 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: Arthur Corliss <corliss@digitalmages.com>
Subject: Re: [PATCH][RFC] fix BSD accounting (w/ long-term perspective ;-)
In-Reply-To: <Pine.LNX.4.53.0403082241200.16420@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0403090030280.23750@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0403082241200.16420@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch for 2.6 kernel is below.

Whoops, missed the incremental hunk below. Corrected full patch is at
  http://www.physik3.uni-rostock.de/tim/kernel/2.6/acct-06.patch

Tim


--- linux-2.6.4-rc1-acct/kernel/acct.c	2004-03-08 22:31:26.000000000 +0100
+++ linux-2.6.4-rc1-acct1/kernel/acct.c	2004-03-09 00:25:50.000000000 +0100
@@ -345,8 +345,8 @@ static void do_acct_process(long exitcod
 	ac.ac_etime = encode_comp_t(jiffies_64_to_AHZ(elapsed));
 	do_div(elapsed, HZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(current->utime);
-	ac.ac_stime = encode_comp_t(current->stime);
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(current->utime));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(current->stime));
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
 #if ACCT_VERSION==1
