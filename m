Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbTAZVrc>; Sun, 26 Jan 2003 16:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTAZVrc>; Sun, 26 Jan 2003 16:47:32 -0500
Received: from mail.hometree.net ([212.34.181.120]:46985 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S267022AbTAZVrb>; Sun, 26 Jan 2003 16:47:31 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [BUG] e100 driver fails to initialize the hardware after kernel bootup through kexec
Date: Sun, 26 Jan 2003 21:56:46 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b11liu$bcl$1@forge.intermeta.de>
References: <1042450072.1744.75.camel@aminoacin.sh.intel.com> <1043390954.892.10.camel@aminoacin.sh.intel.com> <m18yxaeje3.fsf@frodo.biederman.org> <20030124145754.GA1116@an.local> <20030124160748.GB18428@gtf.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1043618206 26968 212.34.181.4 (26 Jan 2003 21:56:46 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 26 Jan 2003 21:56:46 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

>+	/* Wait 20 msec for reset to take effect */
>+	set_current_state(TASK_UNINTERRUPTIBLE);
>+	schedule_timeout(HZ / 50);

Hm. This assumes HZ=100, doesn't it? 

>+	/* Wait for command to be cleared up to 1 sec */
>+	for (i=0; i<1000; i++) {
>+		if (!readb(&bdp->scb->scb_cmd_low))
>+			break;
>+		set_current_state(TASK_UNINTERRUPTIBLE);
>+		schedule_timeout(HZ / 1000);
>+	}

HZ = 100 -> HZ / 1000 == 0 ?

This whole patch scares me. :-)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
