Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269434AbRGaTdm>; Tue, 31 Jul 2001 15:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269436AbRGaTdc>; Tue, 31 Jul 2001 15:33:32 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:37339 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S269434AbRGaTdP>; Tue, 31 Jul 2001 15:33:15 -0400
Date: Tue, 31 Jul 2001 22:33:30 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: vijay srinath <vijaysrinath@lycos.com>
cc: <linux-kernel@vger.kernel.org>, <vikram_kmurthy@yahoo.com>
Subject: Re: SCSI Tape driver problem
In-Reply-To: <MEAIEKBGIFKBAAAA@mailcity.com>
Message-ID: <Pine.LNX.4.33.0107312230140.1548-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, vijay srinath wrote:

> hello all,
>
>     I noticed a bug in the scsi tape class driver in kernel 2.2.16/2.4.x.
> This is the test that i ran.
> 1. I have two scsi-fc tape devices
> 2. I insert the hba driver, so that both the tape devices are enabled and map to st0 and st1
> 3. I remove the device that maps to st0 using
>    echo "scsi remove-single-device 0 0 0 0" > /proc/scsi/scsi
> 4. Now, if i try to do an open("/dev/st1",..), the process hangs as the open call never returns.
>
>     The problem seems to be in the callback function st_sleep_done() where the following comparison is being made
> if ((st_nbr = TAPE_NR(SCpnt->request.rq_dev)) < st_template.nr_dev)
> {
>  ...
> }
>
> This comparision fails for the above test since nr_dev will be 1 and
> TAPE_NR() will also be 1 for /dev/st1. Hence the semaphore
> SCpnt->request.sem never gets released and open waits forever.
>
>
>     Can somebody please let me know why this comparison is needed ?
>
The test was inserted a long time ago to be an additional safeguard
against problems in the code. In normal operation the interrupt function
should never be called with an illegal argument. It seems that the world
around the test has evolved so that the test is not working properly any
more.

You can just remove the test. I will prepare a patch to fix this bug and
send the patch to Linus.

	Kai


