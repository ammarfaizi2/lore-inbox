Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbTAXJAx>; Fri, 24 Jan 2003 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTAXJAx>; Fri, 24 Jan 2003 04:00:53 -0500
Received: from mail.hometree.net ([212.34.181.120]:58518 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S267610AbTAXJAw>; Fri, 24 Jan 2003 04:00:52 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Date: Fri, 24 Jan 2003 09:10:02 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b0qvta$fo6$1@forge.intermeta.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1043399402 13267 212.34.181.4 (24 Jan 2003 09:10:02 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 24 Jan 2003 09:10:02 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

>In drivers/ide/ide-cd.c:cdrom_end_request(), try to insert something
>ala:

>	if ((rq->flags & REQ_SENSE) && uptodate) {
>                struct request *failed = (struct request *) rq->buffer;
>                struct cdrom_info *info = drive->driver_data;
>                void *sense = &info->sense_data;

>+		if (failed && block_pc_request(failed))
>+			printk("%s: failed %p\n", __FUNCTION__, failed->sense);

>                if (failed && failed->sense)
>                        sense = failed->sense;

Shouldn't this be below the 2nd if() and then just test "sense" ?

Like 

>                if (failed && failed->sense)
>                        sense = failed->sense;

>+		if (failed && block_pc_request(failed))
>+			printk("%s: failed %p\n", __FUNCTION__, sense);

That makes sure, that you report what is analyzed later here:

>                cdrom_analyze_sense_data(drive, failed, sense);


	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
