Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbTFQNtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbTFQNtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:49:52 -0400
Received: from arm.t19.ds.pwr.wroc.pl ([156.17.236.105]:53261 "EHLO misie.k.pl")
	by vger.kernel.org with ESMTP id S264731AbTFQNtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:49:45 -0400
Date: Tue, 17 Jun 2003 16:03:39 +0200
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72: drivers/ide/legacy/pdc4030.c:843: error: `hwif' undeclared (first use in this function)
Message-ID: <20030617140338.GA1575@arm.t19.ds.pwr.wroc.pl>
References: <20030617121129.GA9606@arm.t19.ds.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030617121129.GA9606@arm.t19.ds.pwr.wroc.pl>
User-Agent: Mutt/1.4.1i
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/
X-Operating-System: Linux dark 4.0.20 #119 wto cze 17 16:02:33 CEST 2003 i986 pld
Organization: Self Organizing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On/Dnia Tue, Jun 17, 2003 at 02:11:29PM +0200, Arkadiusz Miskiewicz wrote/napisa³(a)
> 
> While building 2.5.72 (+lsm patch):
> 
>  CC [M]  drivers/ide/legacy/pdc4030.o
> drivers/ide/legacy/pdc4030.c: In function `promise_multwrite':
> drivers/ide/legacy/pdc4030.c:617: warning: `return' with a value, in
> function returning void
> drivers/ide/legacy/pdc4030.c: In function `promise_write_pollfunc':
> drivers/ide/legacy/pdc4030.c:627: warning: unused variable `rq'
> drivers/ide/legacy/pdc4030.c: In function `promise_rw_disk':
> drivers/ide/legacy/pdc4030.c:843: error: `hwif' undeclared (first use in
> this function)
> drivers/ide/legacy/pdc4030.c:843: error: (Each undeclared identifier is
> reported only once
> drivers/ide/legacy/pdc4030.c:843: error: for each function it appears
> in.)
> make[3]: *** [drivers/ide/legacy/pdc4030.o] B³±d 1
> make[2]: *** [drivers/ide/legacy] B³±d 2
> make[1]: *** [drivers/ide] B³±d 2
> 

This seems be fix:

--- linux-2.5.72/drivers/ide/legacy/pdc4030.c~	2003-06-17 06:20:02.000000000 +0200
+++ linux-2.5.72/drivers/ide/legacy/pdc4030.c	2003-06-17 16:00:05.000000000 +0200
@@ -818,7 +818,8 @@
 	   Feature register.
 	   FIXME: Is promise_selectproc now redundant??
 	*/
-	int drive_number = (HWIF(drive)->channel << 1) + drive->select.b.unit;
+    	ide_hwif_t *hwif	= HWIF(drive);
+	int drive_number	= (hwif->channel << 1) + drive->select.b.unit;
 #ifdef CONFIG_IDE_TASKFILE_IO
 	struct hd_drive_task_hdr taskfile;
 	ide_task_t args;

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekmatssedotpl AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
