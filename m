Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSBMOhe>; Wed, 13 Feb 2002 09:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSBMOhZ>; Wed, 13 Feb 2002 09:37:25 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44808 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S284933AbSBMOhK>; Wed, 13 Feb 2002 09:37:10 -0500
Message-ID: <3C6A7A07.8000405@evision-ventures.com>
Date: Wed, 13 Feb 2002 15:36:55 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] queue barrier support
In-Reply-To: <20020213135134.A1907@suse.de> <3C6A6571.7070707@evision-ventures.com> <20020213141306.F1907@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Wed, Feb 13 2002, Martin Dalecki wrote:
>
>>Jens Axboe wrote:
>>
>>>Patches attached, comments welcome.
>>>
>>>diff -Nru a/include/linux/ide.h b/include/linux/ide.h
>>>--- a/include/linux/ide.h	Wed Feb 13 13:48:25 2002
>>>+++ b/include/linux/ide.h	Wed Feb 13 13:48:25 2002
>>>@@ -448,6 +448,7 @@
>>>	byte		acoustic;	/* acoustic management */
>>>	unsigned int	failures;	/* current failure count */
>>>	unsigned int	max_failures;	/* maximum allowed failure count */
>>>+	char		special_buf[4];	/* IDE_DRIVE_CMD, free use */
>>>} ide_drive_t;
>>>
>>ide-barrier-1-c1.296:+  memset(drive->special_buf, 0, 
>>sizeof(drive->special_buf));
>>ide-barrier-1-c1.296:+  flush_rq->buffer = drive->special_buf;
>>ide-barrier-1-c1.296:+  char            special_buf[4]; /* 
>>IDE_DRIVE_CMD, free use */
>>
>>I just don't see special_buf used anywhere. What is it supposed to be 
>>used for?
>>Is the intention to make it look like the SCSI code?
>>
>
>See ide.c:ide_queue_flush_cmd(), I'm only using 1 of the bytes but it
>has room for 4 like that is typically used when issuing an ata command
>directly. So yes, it is used, I'm not adding stuff for fun :-)
>

OK I see now. Is this to become analogous to the sr_cmnd field for 
struct scsi_request?
It would make sense to first make them use the same software 
architecture at least and then
to merge as much of this driver mid-layer stuff as possible....


