Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbUCSSjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUCSSjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:39:21 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:30992 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S263097AbUCSSjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:39:02 -0500
Message-ID: <405B3F74.6040706@kolumbus.fi>
Date: Fri, 19 Mar 2004 20:44:04 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <405B200A.40909@kolumbus.fi> <20040319181616.GA2423@suse.de>
In-Reply-To: <20040319181616.GA2423@suse.de>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 19.03.2004 20:41:25,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 19.03.2004 20:40:29,
	Serialize complete at 19.03.2004 20:40:29
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Fri, Mar 19 2004, Mika Penttil? wrote:
>  
>
>>Jens Axboe wrote:
>>
>>    
>>
>>>Hi,
>>>
>>>A first release of a collected barrier patchset for 2.6.5-rc1-mm2. I
>>>have a few changes planned to support dm/md + sata, I'll do those
>>>changes over the weekend.
>>>
>>>Reiser has the best barrier support, ext3 works but only if things don't
>>>go wrong. So only attempt to use the barrier feature on ext3 if on ide
>>>drives, not SCSI nor SATA.
>>>
>>>
>>>
>>>      
>>>
>>What are these brutal pieces...?
>>
>>
>>+static int ide_transform_pc_req(ide_drive_t *drive, struct request *rq)
>>+{
>>+ if (rq->cmd[0] != 0x35) {
>>+ ide_end_request(drive, 0, 0);
>>+ return 1;
>>+ }
>>+
>>+ if (!drive->wcache) {
>>+ ide_end_request(drive, 1, 0);
>>+ return 1;
>>+ }
>>+
>>+ ide_fill_flush_cmd(drive, rq);
>>+ return 0;
>>+}
>>
>>
>>/*
>>+ * basic transformation support for scsi -> ata commands
>>+ */
>>+ if (blk_pc_request(rq)) {
>>+ if (drive->media != ide_disk)
>>+ goto kill_rq;
>>+ if (ide_transform_pc_req(drive, rq))
>>+ return ide_stopped;
>>+ }
>>    
>>
>
>Hmm, I thought it was pretty obvious, even just from the naming and
>comments. Right now, the block layer issued flush without data attached
>(ie a drive barrier without pinning it to a buffer) comes as a scsi
>synchronize cache command. I'm going to change this anyways and allow
>queue hook of a ->issue_flush_fn() that can just tailored to ide or
>scsi, _or_ dm/md and that sort of thing.
>  
>
I mean other BLOCK_PC requests than SYNCHRONIZE CACHE -> 
ide_end_request() and ide_stopped.

--Mika


