Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285243AbRLMWoq>; Thu, 13 Dec 2001 17:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285241AbRLMWo0>; Thu, 13 Dec 2001 17:44:26 -0500
Received: from 70.191.38.66.gt-est.net ([66.38.191.70]:45832 "EHLO
	worm.hmi.net") by vger.kernel.org with ESMTP id <S285233AbRLMWoU>;
	Thu, 13 Dec 2001 17:44:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Olivier Daigle <odaigle@harfangmicro.com>
Organization: Harfang Microtechniques
To: ki@kretz.co.at, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre2: ieee1394 sd hotplug problems (Oops)
Date: Thu, 13 Dec 2001 17:43:58 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011213233150.A8628@boss.kretz.co.at>
In-Reply-To: <20011213233150.A8628@boss.kretz.co.at>
MIME-Version: 1.0
Message-Id: <01121317435803.01045@hubble>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should better ask your question on the linux1394 reflector.

http://sourceforge.net/mail/?group_id=2252

Someone already posted a question regarding the problem you have.

Regards,

   Olivier

On Thursday 13 December 2001 17:31, ki@kretz.co.at wrote:
> Hello all,
>
> I am using an 80GB ide disk together with an
> ide <> firewire converter card. (Oxford chip)
>
> usually I am doing the following: (no SCSI hd present but sd_mod loaded)
>
>  * connect & power on hd
>  * insmod ieee1394, ohci1394 and sbp2
>  * look for the partition info in the syslog, looks like this:
>
> Dec 13 20:24:29 ki_pc2 kernel: scsi0 : IEEE-1394 SBP-2 protocol driver
> Dec 13 20:24:29 ki_pc2 kernel:   Vendor: MAXTOR 4  Model: K080H4           
> Rev: Dec 13 20:24:29 ki_pc2 kernel:   Type:   Direct-Access                
>      ANSI SCSI revision: 06 Dec 13 20:24:29 ki_pc2 kernel: Attached scsi
> disk sdd at scsi0, channel 0, id 0, lun 0 Dec 13 20:24:29 ki_pc2 kernel:
> SCSI device sdd: 156301487 512-byte hdwr sectors (80026 MB) Dec 13 20:24:29
> ki_pc2 kernel:  sdd: sdd1
> Dec 13 20:24:58 ki_pc2 /sbin/hotplug: no runnable
> /etc/hotplug/ieee1394.agent is installed
>
> note: sdd,  not sda as expected
>
>  * use the disk - works ok, hdparm says  ~12MB/sec
>  * rmmod sbp2 (and perhaps also the other 1394 modules)
>  * disconnect hard drive.
>  etc..
>
> The following happens: on  'insmod sbp2' the disk is found
> but the minor device is incremented every time (now I am at /dev/sde :-( )
>
> Trying to open one of the lower (non-present) minors results in an Oops:
>
> in sd.c: at about line 470
>         }
>         /*
>          * The following code can sleep.
>          * Module unloading must be prevented
>          */
>         SDev = rscsi_disks[target].device;
>
> 	^^^^^ this becomes zero for the lower minor devices.
>
>         if (SDev->host->hostt->module) ---- Oops
>
> So it seems that the rmmod sbp2 does not properly clean up
> the internal bookkeeping in sd.c when being unloaded.
>
> I am not sure what happens if scsi-remove-single-device is done instead
> of rmmod sbp2.
>
> OTOH /proc/scsi/scsi correctly shows the present devices
>
> there are a few /dev/sd[a-?]  left so I dont have to reboot every time but
> the situation is a bit non-optimal for now.
>
> Greetings,
> karl

-- 
Olivier Daigle <odaigle@harfangmicro.com>
