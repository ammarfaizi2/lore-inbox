Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUFPLXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUFPLXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUFPLXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:23:07 -0400
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:57491 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266242AbUFPLXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:23:01 -0400
FCC: mailbox://nobody@Local%20Folders/Sent
X-Identity-Key: id3
X-Account-Key: account3
Date: Wed, 16 Jun 2004 21:22:36 +1000
From: Con Kolivas <kernel@kolivas.org>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Mozilla Thunderbird 0.7a (X11/20040614)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: 2.6.7-ck1
Content-Disposition: inline
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406162122.51430.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patchset update. The focus of this patchset is on system responsiveness with
emphasis on desktops, but the scope of scheduler changes now makes this patch 
suitable to servers as well.

http://kernel.kolivas.org

Includes
Staircase scheduler v7.0 (unchanged resync of v6.E)
Extra scheduling policies for staircase:
 Isochronous scheduling - low latency non-privileged (ie soft real time)
 Batch scheduling - idle scheduling
Autoregulated VM swappiness
Supermount-NG v2.04

Changes:
Staircase scheduler and all policies for scheduler updated
Autoregulated swappiness updated to bias exponentially much more like a real 
world system.

Removed:
Sched domains merged into mainline
Hyperthread nice merged into mainline
CFQ I/O elevator merged into mainline
CDDMA merged into mainline
Bootsplash - dropped; patch getting too old to safely merge
Reiser4 - dropped; patch too old
Grsecurity option - dropped; unknown future and breaks SMP
IO Prio - not part of current CFQ scheduler; await new version


Sysctl options:
Staircase scheduler can be set for different workloads:

echo 0 > /proc/sys/kernel/interactive
will disable interactive tasks from having bursts, thus being even stricter 
about nice levels (suitable for non gui desktop usage or a server)

echo 1 > /proc/sys/kernel/compute
makes round robin intervals much longer, delays task preemption and disables
interactive mode to optimise cpu cache usage - suitable for computational
intensive tasks.

Autoregulated swappiness:
echo 0 > /proc/sys/vm/autoswappiness
disables the autoregulated swappiness thus allowing you to set
swappiness manually as exists in mainline

Using schedtool ( http://freshmeat.net/projects/schedtool/?topic_id=136 ) you 
can enable the different scheduling policies:

schedtool -I -e xmms
or
schedtool -I $pid

will start xmms as an "Isochronous" scheduled task. Alternatively if a task
tries to get real time scheduling but you do not have priviliges for RT 
it will drop the task to SCHED_ISO.

schedtool -B -e setiathome

will start setiathome as a "Batch" scheduled task. This means it will 
not get cpu time unless the cpu is completely idle. Note this is _not_ 
suitable for tasks that are disk intensive as a held semaphore can lead to a 
DoS.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0C1+ZUg7+tp6mRURAsDmAJ9bgPhhe8On4UeqEhD6FNcvPGqnWACeJG9C
yNJaCuLgi4AMT7gTPA+CHjw=
=DBuT
-----END PGP SIGNATURE-----
