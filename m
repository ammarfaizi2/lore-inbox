Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSJHIlL>; Tue, 8 Oct 2002 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJHIlL>; Tue, 8 Oct 2002 04:41:11 -0400
Received: from news.cistron.nl ([62.216.30.38]:33541 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261399AbSJHIlK>;
	Tue, 8 Oct 2002 04:41:10 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: experiences with 2.5.40 on a busy usenet news server
Date: Tue, 8 Oct 2002 08:46:20 +0000 (UTC)
Organization: Cistron
Message-ID: <anu60s$oev$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1034066780 25055 62.216.29.67 (8 Oct 2002 08:46:20 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI:

So I booted 2.5.40 with the raid0 fix on our usenet news peering
server yesterday. It is a box that exchanges binary feeds with
about 40 peers, 400 GB/day in, 600 GB/day out.

It's a dual PIII/450, 1 GB RAM, 4x18 GB article spool directly
on partitions (not raw, but normal partitions). INN-2.4/CNFS.

With 2.4.19, it runs fine. With 2.5.40, it goes wildly into
swap. I'm assuming the I/O is pushing the newsserver binaries
and database mappings into swap.

# free
             total       used       free     shared    buffers     cached
Mem:       1033308    1027316       5992          0     836884      29776
-/+ buffers/cache:     160656     872652
Swap:       976888     364032     612856

No need to swap 364 MB when there's 872 MB still free...
This makes the machine dogslow. An 'expire' process that
runs every night normally takes 15 minutes to finish now
has been running for 10 hours and its still not finished.

Article acceptance rate has halved, the machine can't keep up
with the binaries it is fed.

I'm going to risk corrupting the databases and reboot back
to 2.4.19 now.

Mike.

