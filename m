Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUCYDuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUCYDuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:50:21 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:10156 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S263142AbUCYDuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:50:15 -0500
Date: Thu, 25 Mar 2004 09:15:42 +0530
From: mohanlal jangir <mohanlal@samsung.com>
Subject: Re: sleeping in request function
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <011f01c4121b$a6f77a30$7f476c6b@sisodomain.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
 <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz>
 <200403232352.58066.dtor_core@ameritech.net>
 <00cc01c4115d$bad44240$7f476c6b@sisodomain.com> <20040324083313.GG3377@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 24 2004, mohanlal jangir wrote:
> > I have a USB card reader. It is capable of read/write CF, Smartmedia
etc. It
> > works fine on Linux. While looking into driver, I found that the driver
> > works between USB host controller and SCSI layer.
> > Just for learning purpose, I want to write it as block driver. The
functions
> > which performs read/write from the device are blocking. Therefore I
can't
> > call these functions directly from request function. Can somebody tell
me
> > how can I call blocking functions from request function. I tried to set
BH
> > but it didn't work.
>
> First of all, don't start a new thread by replying to some other mail.
> Your mail header includes references to that thread, thus screwing
> proper threading.
>
I am sorry for this. I will take care in future.

> You could push your request handling off to some thread to do the work
> for you, see how drivers/block/loop.c does this.
> --
> Jens Axboe
>
>
I will look into this code. At this point of time, I have another question.
Say an application calls read on the device and the data to be read is not
present in buffer cache. This should cause "request function" to be called
(read is waiting for completion). If request function hands over this to
some thread (which will perform actual read later) and returns, then what
happens to the read called in application (which was blocking). Because by
the time read in application returns, it should have read data. I am very
confused about this. Could someone shed some light on this?

Regards
Mohanlal


