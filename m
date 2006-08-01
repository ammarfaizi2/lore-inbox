Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWHAHzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWHAHzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422751AbWHAHzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:55:42 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:62397 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1422746AbWHAHzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:55:41 -0400
Message-ID: <44CEECFE.4000704@s5r6.in-berlin.de>
Date: Tue, 01 Aug 2006 07:56:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Philippe Troin <phil@fifi.org>
CC: Patrick Mau <mau@oscar.ping.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question about "Not Ready" SCSI error
References: <20060730181014.GA13456@oscar.prima.de> <877j1tid0h.fsf@tantale.fifi.org>
In-Reply-To: <877j1tid0h.fsf@tantale.fifi.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin wrote:
> Patrick Mau <mau@oscar.ping.de> writes:
...
>> Jul 30 15:51:30 tony kernel: sd 0:0:0:0: Device not ready: <6>: Current: sense key=0x2
>> Jul 30 15:51:30 tony kernel: ASC=0x4 ASCQ=0x2
>> Jul 30 15:51:30 tony kernel: end_request: I/O error, dev sda, sector 617358
>> 
>> Google revealed[1] that the drive is waiting for a START UNIT command,
>> but it seems that the kernel is not attempting to spin up the drive
>> again. 
>> 
>> After a complete power-cycle the drive worked again. I just wanted to
>> know if this is a shortcoming in the SCSI error handling codepath.
> 
> I'll have to report that I've seen a few drives behaving similarly,
> both on 2.4.x and 2.6.x.
> 
> Is that an expected behavior from SCSI hard drives?  Any SCSI guru
> would be able to answer this one?

I am not a SCSI guru but answer anyway. The gurus are over at
linux-scsi@vger.kernel.org.

Doug Gilbert has an overview about SCSI power management:
http://sg.torque.net/sg/power.html

Long ago Brian King submitted code to the SCSI error handler of Linux
2.6 that issues the START STOP UNIT command. This code is inactive per
default to avoid clashes with USB disks.
http://marc.theaimsgroup.com/?l=linux-scsi&m=107702811830956

A recently merged patch allows to activate this code via a sysfs
attribute. http://lkml.org/lkml/2006/7/30/261

I don't know if there is similar code for Linux 2.4.
-- 
Stefan Richter
-=====-=-==- =--- ----=
http://arcgraph.de/sr/
