Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTE2Azv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 20:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTE2Azv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 20:55:51 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:19142 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261787AbTE2Azu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 20:55:50 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: pee@erkkila.org
Date: Thu, 29 May 2003 11:08:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16085.23940.164807.702704@notabene.cse.unsw.edu.au>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm1 bootcrash, possibly RAID-1
In-Reply-To: message from Paul E. Erkkila on Wednesday May 28
References: <20030408042239.053e1d23.akpm@digeo.com>
	<3ED49A14.2020704@aitel.hist.no>
	<20030528111345.GU8978@holomorphy.com>
	<3ED49EB8.1080506@aitel.hist.no>
	<20030528113544.GV8978@holomorphy.com>
	<20030528225913.GA1103@hh.idb.hist.no>
	<3ED54685.5020706@erkkila.org>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings all.

I think this might fix the bug, but I haven't looked very closely
yet.  I will expore it more deeply when I get time.

NeilBrown



 ----------- Diffstat output ------------
 ./drivers/md/raid1.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2003-05-29 11:05:03.000000000 +1000
+++ ./drivers/md/raid1.c	2003-05-29 11:05:08.000000000 +1000
@@ -137,7 +137,7 @@ static void put_all_bios(conf_t *conf, r
 			BUG();
 		bio_put(r1_bio->read_bio);
 		r1_bio->read_bio = NULL;
-	}
+	} else
 	for (i = 0; i < conf->raid_disks; i++) {
 		struct bio **bio = r1_bio->write_bios + i;
 		if (*bio) {
