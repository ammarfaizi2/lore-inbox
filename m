Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTABABp>; Wed, 1 Jan 2003 19:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbTABABp>; Wed, 1 Jan 2003 19:01:45 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:51626 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265238AbTABABo>; Wed, 1 Jan 2003 19:01:44 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Date: Thu, 2 Jan 2003 11:09:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15891.33615.121943.544956@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID0 problems with 2.4.21-BK current
In-Reply-To: message from Marc-Christian Petersen on Sunday December 29
References: <200212292012.11556.m.c.p@wolk-project.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday December 29, m.c.p@wolk-project.de wrote:
> Hi Neil,
> 
> this:
> 
> http://linux.bkbits.net:8080/linux-2.4/patch@1.884.1.69?nav=index.html|ChangeSet@-2w|cset@1.884.1.69
> 
> patch breaks at least RAID 0 recognition at boottime (infinite loop) and also 
> breaks mkraid /dev/md0. Never stops, State D.
> 
> Ripping the patch out helps.

Is your raid0 ontop of a raid1 ???
If so, this patch is needed.

NeilBrown

--------------------------------------------------------
Set BH_Locked when accessing MD superblocks

Some silly drivers (like raid1 !!) want  BH_Locked to be set on all IO,
so we humour them by setting the bit when doing superblock IO.

 ----------- Diffstat output ------------
 ./drivers/md/md.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2002-12-17 15:20:57.000000000 +1100
+++ ./drivers/md/md.c	2003-01-02 11:05:20.000000000 +1100
@@ -489,7 +489,7 @@ static int sync_page_io(kdev_t dev, unsi
 	init_buffer(&bh, bh_complete, &event);
 	bh.b_rdev = dev;
 	bh.b_rsector = sector;
-	bh.b_state	= (1 << BH_Req) | (1 << BH_Mapped);
+	bh.b_state	= (1 << BH_Req) | (1 << BH_Mapped) | (1 << BH_Locked);
 	bh.b_size = size;
 	bh.b_page = page;
 	bh.b_reqnext = NULL;
