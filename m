Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbRGJEg4>; Tue, 10 Jul 2001 00:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbRGJEgr>; Tue, 10 Jul 2001 00:36:47 -0400
Received: from gear.torque.net ([204.138.244.1]:12553 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S265472AbRGJEgi>;
	Tue, 10 Jul 2001 00:36:38 -0400
Message-ID: <3B4A85BD.FE0E2D61@torque.net>
Date: Tue, 10 Jul 2001 00:34:05 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4.3] scsi logging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> I'd like to propose the following patch to 3 SCSI mid-layer 
> files from kernel 2.4.3.  I have tested this with 2.4.3, 
> but it should be relevant to other 2.4.x kernels also.
> 
> It has the following changes/enhancements:
> 1) Log the disk serial number during scsi_scan() 
>    - scsi_scan.c.
>    Why: This is a requirement in some environments to 
>    ensure unambiguous identification of a particular 
>    problem disk.
> 2) Interpret additional values in print_sense_internal()
>    - constants.c.  Why: The detail wrt Illegal Requests 
>    is very useful, since it can indicate either an 
>    application bug or an incompatible feature of the device.
> 3) Don't skip logging sense errors for sg functions - sg.c.
>    Why: All sense errors should be logged so that a 
>    potential scsi device hardware problem doesn't go
>    unrecognized.

Andrew,
I would object to point 3). SANE, and to a lesser extent
cdrecord, execute lots of commands that give SCSI check
conditions and would bloat the log and the console with
many serious looking messages. Those error 
indications are conveyed back to the app via the sg 
interface so the information is not lost. There is an 
ioctl in the sg driver [SG_SET_DEBUG] to turn on that 
output to the log/console [the default is off (to
stop the curious querying the maintainer about the
strange messages in their logs)].

Doug Gilbert
