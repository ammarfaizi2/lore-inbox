Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286936AbSABLVy>; Wed, 2 Jan 2002 06:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbSABLVo>; Wed, 2 Jan 2002 06:21:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286936AbSABLVd>; Wed, 2 Jan 2002 06:21:33 -0500
Subject: Re: SCSI host numbers?
To: nahshon@actcom.co.il
Date: Wed, 2 Jan 2002 11:32:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201020119.g021JoK32730@lmail.actcom.co.il> from "Itai Nahshon" at Jan 02, 2002 03:19:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LjdE-0003m4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Under some scenarios Linux assigns the same
> host_no to more than one scsi device.
> 
> Can someone tell me what is the intended behavior?

A number should never be reissued.

> The problem is that a newly registered device gets
> its host_no from max_scsi_host. max_scsi_host is
> decremented when a device driver is unregistered
> (see drivers/scsi/host.c) allowing a second new
> host to reuse the same host_no.

I guess it needs to either only decrement the count if we are the highest one 
(trivial hack) or scan for a free number/keep a free bitmap. The devfs code
has a handy little unique_id function for that 
