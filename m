Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVCBTXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVCBTXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVCBTWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:22:47 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:2512 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262421AbVCBTR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:17:29 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.6.11: iostat values broken ?
Date: Wed, 2 Mar 2005 19:17:28 +0000 (UTC)
Organization: Cistron
Message-ID: <d053g8$6et$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1109791048 6621 194.109.0.112 (2 Mar 2005 19:17:28 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgrades one of our newsservers from 2.6.9 to 2.6.11. I
use "iostat -k -x 2" to see live how busy the disks are. But
I don't believe that Linux optimizes things so much that a disk
can be 1849.55% busy :)

(you'll have to stretch out your xterm to be able to read this):

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
hda          0.00  50.00  0.00 18.18    0.00  545.45     0.00   272.73    30.00     2.35  129.00  86.25 156.82
hdc          0.00  45.45 77.27 31.82 3927.27  618.18  1963.64   309.09    41.67     6.27   57.42  38.42 419.09
hdd          4.55   0.00 63.64  0.00   68.18    0.00    34.09     0.00     1.07     1.11   17.43  17.43 110.91
hde        477.27   0.00 45.45  0.00  522.73    0.00   261.36     0.00    11.50     0.40    8.90   8.90  40.45
hdg         18.18 70154.55 22.73 172.73   40.91 70727.27    20.45 35363.64   362.07  1010.36 1127.72  94.63 1849.55

With 2.6.9, %util never came above 100% (and that was indeed "fully loaded".
I have systems with a comparable load running 2.6.10 and 2.6.11-rc3-bk4
that also don't show this behaviour (but those are SCSI, not IDE).

I use CFQ, but changing that to deadline doesn't make a difference.

Mike.

