Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261727AbTCNKt6>; Fri, 14 Mar 2003 05:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbTCNKt6>; Fri, 14 Mar 2003 05:49:58 -0500
Received: from portal.beam.ltd.uk ([62.49.82.227]:33920 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S261727AbTCNKt4>;
	Fri, 14 Mar 2003 05:49:56 -0500
Message-ID: <3E71B629.60204@beam.ltd.uk>
Date: Fri, 14 Mar 2003 10:59:53 +0000
From: Terry Barnaby <terry@beam.ltd.uk>
Organization: Beam Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: mmadore@aslab.com, gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We may be experiencing the same problem.
In our case it results in the SEAGATE ST336607LW drive locking up solid 
with no hardware reset possible.

Our problem is that our 320MB/s SEAGATE ST336607LW drive will lockup 
after about 10mins to 2hours of serious activity (Copying disk partitions).
.
The primary error message we see is:
"Saw underflow (16384 of 20480 bytes). Treated as error"
followed by various SCSI error messages. The SCSI disks LED
remains on and it is impossible to access the SCSI disk. The system
will then hang. Reseting the system does not clear the SCSI disk LED and
the SCSI disk is not seen in the Adaptec BIOS on startup. A power off/on
cycle will clear the condition.

We have been trying to track down the problem for about two weeks now 
and we are still unsure where the problem lies: Disk, SCSI cable, SCSI 
controller or Linux driver.

Some info we do have though is:
1. Setting the SCSI bus speed from 320MB/s to 160MB/s does not affect 
the problem.
2. Switching off packetized mode fixes the problem (we think).
3. Using a non SMP kernel may fix the problem (we are testing at this 
moment).

Our system is:
System: Dual Xeon 2.4GHz system using SuperMicro X5DA8 Motherboard.
SCSI: Adaptec 7902 onboard dual channel SCSI controller
Disks: 2 off Quantum Atlas 10K2 18G (160LW), 1 of Quantum 9G (80LW)
Disks: 1 off Seagate ST336607LW 36G (320LW)
System: RedHat 7.3 with updates to 18/02/03
Kernel: 2.4.18-24.7.xsmp
Aic79xx Driver: versions 1.0.0 and 1.1.0

Our current view is that there are two problems:
1. There is a timing/SMP issue with the Linux AIC79XX SCSI driver in SMP 
systems that cause and incorect SCSI bus condition.
2. The SEAGATE ST336607LW responds to this condition by locking up and
cannot be reset. We have information from Seagate that it is possible 
for the ST336607LW to get in a condition where it cannot be reset !

We have had a lot of communications with Seagate on this so far to no
avail. We have quite a lot of information in terms of log files etc.

Is there a good contact for someone who knows about the Adaptec AIC79XX
driver that we could talk to ?

Any help would be appreciated.

Terry


> I am receiving the following messages in my system log when stress testing
> with Cerberus (http://sourceforge.net/projects/va-ctcs). This is with an
> onboard Adaptec 7902 Ultra 320 SCSI adapter. The messages are reproducible
> on two different systems. This is with the 1.1.0 aic79xx driver, on
> both the
> stock Redhat kernel, and with a kernel compiled from the 2.4.19 sources.
> The
> system does not seem to be harmed by the messages, but I would like to
> know if
> they point to a problem or not. Interestingly, if I put and Adaptec
> 29320 PCI
> card into the same machine, and use the same driver, the error is not
> reproducible.
> 
> Mike 


-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"

