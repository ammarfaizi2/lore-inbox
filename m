Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSBMNNm>; Wed, 13 Feb 2002 08:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbSBMNNa>; Wed, 13 Feb 2002 08:13:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62733 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S276424AbSBMNNP>;
	Wed, 13 Feb 2002 08:13:15 -0500
Date: Wed, 13 Feb 2002 14:13:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] queue barrier support
Message-ID: <20020213141306.F1907@suse.de>
In-Reply-To: <20020213135134.A1907@suse.de> <3C6A6571.7070707@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6A6571.7070707@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> 
> >Patches attached, comments welcome.
> >
> >diff -Nru a/include/linux/ide.h b/include/linux/ide.h
> >--- a/include/linux/ide.h	Wed Feb 13 13:48:25 2002
> >+++ b/include/linux/ide.h	Wed Feb 13 13:48:25 2002
> >@@ -448,6 +448,7 @@
> >	byte		acoustic;	/* acoustic management */
> >	unsigned int	failures;	/* current failure count */
> >	unsigned int	max_failures;	/* maximum allowed failure count */
> >+	char		special_buf[4];	/* IDE_DRIVE_CMD, free use */
> >} ide_drive_t;
> >
> ide-barrier-1-c1.296:+  memset(drive->special_buf, 0, 
> sizeof(drive->special_buf));
> ide-barrier-1-c1.296:+  flush_rq->buffer = drive->special_buf;
> ide-barrier-1-c1.296:+  char            special_buf[4]; /* 
> IDE_DRIVE_CMD, free use */
> 
> I just don't see special_buf used anywhere. What is it supposed to be 
> used for?
> Is the intention to make it look like the SCSI code?

See ide.c:ide_queue_flush_cmd(), I'm only using 1 of the bytes but it
has room for 4 like that is typically used when issuing an ata command
directly. So yes, it is used, I'm not adding stuff for fun :-)

-- 
Jens Axboe

