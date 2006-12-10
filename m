Return-Path: <linux-kernel-owner+w=401wt.eu-S1760732AbWLJNqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760732AbWLJNqj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 08:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760737AbWLJNqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 08:46:39 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33396 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760732AbWLJNqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 08:46:39 -0500
Date: Sun, 10 Dec 2006 14:46:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Window scaling problem?
Message-ID: <Pine.LNX.4.61.0612101001390.9675@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


for some reason unknown to me, some TCP connections just hang or get
reset after some kilobytes have been transferred. I suppose it is a
router with broken window scaling, but I can not say for sure from
the tcpdump logs.

Action:
  scp ahn.hopto.org:8megabytefile /home/jengelh/
  also affects interactive ssh sessions.
Result:
  After a few transferred kilobytes -- I rather suspect "a few
  seconds" -- either spuriously disconnects with a "Connection reset
  by peer" or just hangs.
Expected result:
  Continue operation.
Logs:
  http://jengelh.hopto.org/tcp/atw.txt    sender side
  http://jengelh.hopto.org/tcp/ahn.txt    receiver side
  http://jengelh.hopto.org/tcp/trace.txt  glimpse of topology

(There is a TCP FIN/RST at the end of atw.txt, which is when I hit
Ctrl+C to stop the (hung) scp.)

What puzzles me is that line 230 of ahn.txt shows a RST, while
there is no TCP RST sent in atw.txt. On top of that, the "R
889945325:889945325(0)" looks quite out of order.

When setting up a VPN over UDP tunnel (using vpnc) to our exit node,
connections seem to be fine. I hence suppose 10.10.96.1 to be
the culprit.

If anyone could take a look, I'd be grateful. Kernel currently
running is 2.6.18.5, but I have seen this with 2.6.17 I was running
two months ago too, so I do not suspect a kernel bug.


	-`J'
-- 
