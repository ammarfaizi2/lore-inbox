Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbUB0Qcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbUB0Qcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:32:53 -0500
Received: from mxout2.iskon.hr ([213.191.128.16]:34772 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S263034AbUB0Qcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:32:50 -0500
X-Remote-IP: 213.191.128.12
X-Remote-IP: 213.191.128.21
To: Jochen Roemling <jochen@roemling.net>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it>
	<1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net>
	<20040226160616.E1652@build.pdx.osdl.net>
	<20040226163236.M22989@build.pdx.osdl.net>
	<403E958B.6020406@roemling.net> <20040227011151.GT693@holomorphy.com>
	<403E9E54.6030404@roemling.net>
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Fri, 27 Feb 2004 17:32:46 +0100
In-Reply-To: <403E9E54.6030404@roemling.net> (Jochen Roemling's message of
 "Fri, 27 Feb 2004 02:33:08 +0100")
Message-ID: <dnad34xz2p.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Roemling <jochen@roemling.net> writes:

> William Lee Irwin III wrote:
>
>>Check /proc/sys/vm/nr_hugepages and /proc/sys/kernel/shmmax also.
>>
>>
> cat /proc/sys/vm/nr_hugepages
> 64
>
> cat /proc/sys/kernel/shmmax
> 33554432
>
> cat /proc/meminfo | grep Huge
> HugePages_Total:    64
> HugePages_Free:     62
> Hugepagesize:     4096 kB
>
> but again: root can, users cannot, so sizes won't matter, would they?

Of course! Appended simple patch is what i did (ugly, I know) and that
helped me install Oracle10g on Debian unstable (with two other
adaptations). I don't know how in the hell I forgot to put that
important patch on my page where I explain how to install Oracle10g on
Debian?! Sorry, it'll be on http://linux.inet.hr/oracle10g_on_debian.html
later today or tomorrow, after I check some other problems people have
reported to me (and you Jochen, too :)).

Index: 3.3/fs/hugetlbfs/inode.c
--- 3.3/fs/hugetlbfs/inode.c Thu, 19 Feb 2004 19:05:15 +0100 zcalusic (linux26/D/6_inode.c 1.1.1.2 644)
+++ 3.4/fs/hugetlbfs/inode.c Mon, 23 Feb 2004 09:33:52 +0100 zcalusic (linux26/D/6_inode.c 1.1.1.3 644)
@@ -694,9 +694,6 @@
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
-		return ERR_PTR(-EPERM);
-
 	if (!is_hugepage_mem_enough(size))
 		return ERR_PTR(-ENOMEM);
 	n = atomic_read(&hugetlbfs_counter);

Regards,
-- 
Zlatko

P.S. Please Cc: me, I'm not subscribed.
