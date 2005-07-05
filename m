Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVGEBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVGEBIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGEBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 21:08:35 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:665 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261743AbVGEBIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 21:08:30 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Date: Tue, 5 Jul 2005 11:08:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17097.56705.490622.759154@cse.unsw.edu.au>
Subject: REGRESSION in 2.6.13-rc1: Massive slowdown with Adaptec SCSI
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I have a server with a:
        SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
        Subsystem: Adaptec AHA-3960D U160/m

 connected to 14 
      Vendor: MAXTOR   Model: ATLAS15K_36SCA   Rev: DTA0

 7 on each channel.

 On  2.6.12  a simple 'dd' write test gives 70 Meg/second:

cage #  time dd of=/dev/null if=/dev/sdl bs=1024k count=100
100+0 records in
100+0 records out
104857600 bytes transferred in 1.555210 seconds (67423431 bytes/sec)

real    0m1.557s
user    0m0.001s
sys     0m0.770s


 On 2.6.13-rc1 the same test takes just short on 1 minute and reports
 slightly less than 2 M/Second.

cage #  time dd of=/dev/null if=/dev/sdl bs=1024k count=100
100+0 records in
100+0 records out
104857600 bytes transferred in 54.576592 seconds (1921293 bytes/sec)

real    0m54.578s
user    0m0.000s
sys     0m0.360s

I'm happy to try patches or perform other tests.

NeilBrown
