Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbTCFIUE>; Thu, 6 Mar 2003 03:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTCFIUD>; Thu, 6 Mar 2003 03:20:03 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:59537 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267925AbTCFIUC>; Thu, 6 Mar 2003 03:20:02 -0500
Date: Thu, 6 Mar 2003 00:30:54 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
Message-ID: <20030306083054.GB1503@beaverton.ibm.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl> <20030306064921.GA1425@beaverton.ibm.com> <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo [zwane@linuxpower.ca] wrote:
> scsi1 : QLogic ISP1020 SCSI on PCI bus 04 device 70 irq 89 MEM base 0xf8a18000
> scsi: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 0 lun 0
> scsi: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 1 lun 0
> 

Did this work in 2.5.62? The qlogicisp driver does have any error
handlers. Any error will cause a device offline state. You
should see a message at boot like:
ERROR: This is not a safe way to run your SCSI host            
ERROR: The error handling must be added to this driver

This does not explain what is causing the error handler to start up or
do anything to help your problem.

We have been switching to the feral driver to handle the qlogic isp
card. This driver contains error handling routines. I believe the 2.5
versions of the driver is in the -mm tree. I also believe Andrew has it
as a separate patch. 

I did try running the qlogicisp driver and it appears to be loading for
me, but I do not have any non-disk devices on the system at the moment.

-andmike
--
Michael Anderson
andmike@us.ibm.com

