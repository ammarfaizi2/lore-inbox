Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbTCTQcK>; Thu, 20 Mar 2003 11:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbTCTQcK>; Thu, 20 Mar 2003 11:32:10 -0500
Received: from fmr01.intel.com ([192.55.52.18]:33273 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261550AbTCTQcG>;
	Thu, 20 Mar 2003 11:32:06 -0500
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D6EF@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Terry Barnaby'" <terry@beam.ltd.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Reproducible SCSI Error with Adaptec 7902 & ST336607LW
Date: Thu, 20 Mar 2003 08:46:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry,

Did you try changing the mode pages on the Seagate ST336607LW to turn off
SMART?
The symptoms indicate to me that SMART might be an issue.

Andy

-----Original Message-----
From: Terry Barnaby [mailto:terry@beam.ltd.uk] 
Sent: Thursday, March 20, 2003 5:07 AM
To: linux-kernel@vger.kernel.org
Cc: Justin T. Gibbs; mmadore@aslab.com
Subject: Re: Reproducible SCSI Error with Adaptec 7902


Hi,

We have continued to try and get to the bottom of the problem we have
with the Seagate ST336607LW drive with an Adaptec 7902 SCSI controller
under Linux on an SMP machine. We have recently tried the latest
Adaptec Linux driver (1.3.4) from Justin Gibbs who is one of the Adaptec
SCSI driver developers. This has stopped the drive locking up but now
lists SCSI errors in the log files. I enclose a portion of this log
file. I have run the error logs past Justin and he has stated:

"The drive has unexpectedly dropped off the bus during a connection.
Without a SCSI bus trace it is impossible to know why the drive might
have done this or if perhaps a glitch on the BSY line is causing the
controller to detect a spurious busfree."

My current conclusions are:

1. The Seagate ST336607LW drive has a bug where in certain circumstances
	the drive can lock up, with LED on. In this state it will not
	respond to a hardware reset and a power off/on cycle is needed to
	reset the drive. There is a difference between the way the Linux
	Adaptec AIC79XX 1.1.0 driver and the 1.3.4 driver handles a SCSI
	error condition that triggers this behaviour.

2. There is a problem with one of the following: The Seagate ST336607LW
drive,
	the Adaptec 7902 SCSI controller on the SuperMicro X5DA8 Motherboard
or
	the Linux AIC79XX driver that causes a SCSI bus fault.

I am now giving up with Seagate ST336607LW drive and intend to try a
Maxtor Atlas 10K IV drive instead.
I include this information to hopefully assist others who may encounter this
problem and to list the bugs so that those who are in a position to fix them
know about it.

Terry

[...snip...]
