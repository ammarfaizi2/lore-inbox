Return-Path: <linux-kernel-owner+w=401wt.eu-S1760303AbWLJGge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760303AbWLJGge (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 01:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760299AbWLJGge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 01:36:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56067 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760298AbWLJGgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 01:36:33 -0500
Date: Sat, 9 Dec 2006 22:36:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: manz@intes.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI Controler SCRU32 becomes realy slow on the latest kernels
Message-Id: <20061209223616.356229cc.akpm@osdl.org>
In-Reply-To: <200612071428.44850.manz@intes.de>
References: <200612071428.44850.manz@intes.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 7 Dec 2006 14:28:44 +0100 Hartmut Manz <manz@intes.de> wrote:
> I am using here 2 machines with the ICP Vortex SCSI-Controler SCRU32 for some 
> years now.
> 
> After switching one machine from Debian 3.1 (sarge, with Kernel 2.6.8) to the 
> upcoming Debian 4.0 (etch with Kernel 2.6.17 or 2.6.18) I have noticed that 
> my scsi-devices become very slow while there is also a dramatical increase in
> the sys time needed for I/O operations.
> 
> The machine is a dual processor Xeon system (2 * 2.2 GHz) with 2 GB memory.
> The used scsi drives are seagate R10k and R15k disks.
> 
> i.e.  reading 1 GB from the first SCSI drive takes about:
> xen-1:/var/log# time dd if=/dev/sda bs=256k count=4000 of=/dev/null
> 4000+0 records in
> 4000+0 records out
> 1048576000 bytes (1.0 GB) copied, 55.3079 seconds, 19.0 MB/s
> 
> real    0m55.361s
> user    0m0.368s
> sys     0m49.107s

ouch.

> There are two strange things: 
>    1. The transfer rate is only 19 MB/sec what is very low for this machine.
>        The expected value would be at least 50 MB/sec.
> 
>    2. the system time is in the same range as the real time and thats
>        realy annoying,  on the old kernel the system time for such an operatin
>        was about 7 sec.
> 

It would help a lot of we can determine where the kernel is spending all this
time.  Can you please generate a kernel profile?

Start a large IO operation then, while it is running, run

#!/bin/sh
sudo opcontrol --stop
sudo opcontrol --shutdown
sudo rm -rf /var/lib/oprofile
sudo opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
sudo opcontrol --start-daemon
sudo opcontrol --start
sleep 10
sudo opcontrol --stop
sudo opcontrol --shutdown
sudo opreport -l /boot/vmlinux-$(uname -r) | head -50

(might need some adjustments for distro variation)

Thanks.
