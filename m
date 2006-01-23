Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWAWIj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWAWIj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWAWIj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:39:59 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:6901 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751439AbWAWIj6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:39:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fup9sMR8eYE6uTqU4vYAZI9X2vDdbPgl1utduQk/NfESzzOd5X4SOZGTpvu2apQ/prwG5RpqsvPc7onciRRWq3v1jmrF7OPh0eWLSZHk7OyD2EZkBAM8DavRNsqctnXIWBBIKZ0h/n7IY+VgfWiykq0/x1ypHAgxIYDiGNlRJyw=
Message-ID: <58cb370e0601230039q2fe64b2sc1c5f208ccc3f287@mail.gmail.com>
Date: Mon, 23 Jan 2006 09:39:56 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [PATCH] Add ide_bus_type probe and remove methods
In-Reply-To: <20060114195753.GC24816@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11371818112032@kroah.com> <11371818123046@kroah.com>
	 <58cb370e0601131206u2507f8fewba34336c556ea61b@mail.gmail.com>
	 <20060114195753.GC24816@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Fri, Jan 13, 2006 at 09:06:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > please fix ide-scsi.c (should be trivial)
>
> Updated patch attached.  However, unable to even build-test since ide-scsi
> is already broken:
>
> drivers/scsi/ide-scsi.c: In function `idescsi_eh_reset':
> drivers/scsi/ide-scsi.c:1046: error: too few arguments to function `end_that_request_last'
> drivers/scsi/ide-scsi.c:1056: error: too few arguments to function `end_that_request_last'

It seems that ide-scsi was fine after all...

> @@ -1046,7 +1043,7 @@ static int idescsi_eh_reset (struct scsi
>
>         /* kill current request */
>         blkdev_dequeue_request(req);
> -       end_that_request_last(req, 0);
> +       end_that_request_last(req);
>         if (req->flags & REQ_SENSE)
>                 kfree(scsi->pc->buffer);
>         kfree(scsi->pc);
> @@ -1056,7 +1053,7 @@ static int idescsi_eh_reset (struct scsi
>         /* now nuke the drive queue */
>         while ((req = elv_next_request(drive->queue))) {
>                 blkdev_dequeue_request(req);
> -               end_that_request_last(req, 0);
> +               end_that_request_last(req);
>         }
>
>         HWGROUP(drive)->rq = NULL;
