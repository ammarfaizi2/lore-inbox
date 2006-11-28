Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757736AbWK1BUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736AbWK1BUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758584AbWK1BUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:20:31 -0500
Received: from castle.comp.uvic.ca ([142.104.5.97]:54714 "EHLO
	castle.comp.uvic.ca") by vger.kernel.org with ESMTP
	id S1757736AbWK1BUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:20:30 -0500
Message-ID: <456B8EBC.7070801@uvic.ca>
Date: Mon, 27 Nov 2006 17:19:56 -0800
From: Evan Rempel <erempel@uvic.ca>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI init discussion/SAN problem (not interesting)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-UVic-Virus-Scanned: OK - Passed virus scan by Sophos (sophie) on castle
X-UVic-Spam-Scan: castle.comp.uvic.ca Not_scanned_LOCAL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Was this post just not interesting enough, or is it the lack of access to hardware
to test this on that prevented it from being picked up by someone?

If it is lack of access to hardware, I am sure  my organization can provide
a solution.

Evan.

On Nov 17, 2006 Evan Rempel wrote:
> 
> I have a problem with the order that the SCSI subsystem attaches disk 
> devices that shows up in a multipath environment.
> 
> My understanding is that during the finishing phase of the SCSI 
> subsystem the partition table is read from the drive and the bare drive 
> and each partition are registered with the kernel. Please correct me if 
> I am wrong becuase I am not a kernel developer even at the tinkering level.
> 
> The problem shows up in a multipath environment where the same physical 
> device has it's partition table read and then registered with the kernel 
> *for each path on which it available*. I understand the requirement for 
> the second (possibly more) devices registered with the kernel, and I 
> want this behaviour to continue (how else would multipath work?).
> The problem is that reading the partition table on each of the paths 
> causes I/O to be generated to the physical disk on each of the paths.
> For some disk controllers (any with active/passive controllers) this 
> will initial a failover event from the active to the passive controller. 
> This failover can take a few seconds, but multipathing may result in 
> 100's of such paths and failover events which make the boot time very 
> long. I have a machine that takes close to 1hr to boot due to this 
> behavior.
> 
> What I would like to have considered is the ability to get the serial 
> number/WWName of the device prior to reading the partition table. If the 
> serial number/WWName has already been registered under a different SCSI 
> ID, then just use the partition table that was used to load the first 
> instance. This will result in I/O only on the first path to each disk.
> 
> Another thing that might make things even better is to do something like 
> the mp_prio utils of multipathing do and determine which paths is an 
> active path, and only read the partition table from the active paths.
> This may require a 2 pass device registration mechanism becuase it may 
> be possible that none of the paths are active paths, meaning that the 
> device did not get registered by the end of the device list. We would 
> have to go back to the beginning of the list and for any device that was 
> not yet registered with the kernel, read the serial number/WWName and 
> partition table, register with the kernel and then determine if any of 
> the other paths are for the same device to load them into the kernel.
> 
> I hope this is clear enough to start a dialog on how to change the scsi 
> initialization faster for large systems on multipath hardware.
> 
> Evan Rempel
> Senior Programmer Analyst
> University of Victoria

