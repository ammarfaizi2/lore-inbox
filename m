Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVDAPIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVDAPIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVDAPIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:08:36 -0500
Received: from upco.es ([130.206.70.227]:5613 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262757AbVDAPIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:08:13 -0500
Date: Fri, 1 Apr 2005 17:08:10 +0200
From: Romano Giannetti <romanol@upco.es>
To: Maximilian Engelhardt <maxi@daemonizer.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Call for help: list of machines with working S3
Message-ID: <20050401150810.GA21157@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Maximilian Engelhardt <maxi@daemonizer.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>
References: <3xVNA-Qn-43@gated-at.bofh.it> <1111089912.9802.26.camel@mobile> <20050318145028.GA22887@pern.dea.icai.upco.es> <1112298873.10156.18.camel@mobile> <20050401091708.GA31787@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050401091708.GA31787@pern.dea.icai.upco.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 11:17:08AM +0200, Romano Giannetti wrote:
> and nothing more. Well, this was done with the double console, so that I
> will try again as soon as I have a bit of time with just the serial console
> on. 

Much better now. Configuration, dmesg at boot, etc are at 
http://www.dea.icai.upco.es/romano/linux/config-2.6.12-rc1-rg/

I booted the 2.6.12-rc1 kernel above (with the alps resume fix) with the 
options: console=ttyS0,115200n8 init=/bin/bash

The full log of the session, if it's interesting to someone, is here: 
http://www.dea.icai.upco.es/romano/linux/swsusp/2612rc1-bash.s3.log

The interesting part is here. At suspend I have: 

bash-2.05b# echo -n 3 > /proc/acpi/sleep
[4294743.859000] Stopping tasks: ===|

and the laptop goes off with suspend light blinking. Ok. After a 20 sec, I
hit the power button and: 

[4294759.817000]  evevent-0286: *** Error: No installed handler for fixed
event
[00000002]
[4294759.827000] Restarting tasks... done
bash-2.05b#

I have the prompt back! But the HDD light is fixed on... I tried lsmod: 

bash-2.05b# lsmod

Dead. After a bit it says: 

[4294828.522000] hda: dma_timer_expiry: dma status == 0x21
[4294838.522000] hda: DMA timeout error
[4294838.526000] hda: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
[4294838.536000]
[4294838.538000] ide: failed opcode was: unknown
[4294838.546000] hda: task_in_intr: status=0x59 { DriveReady SeekComplete
DataRequest Error }
[4294838.556000] hda: task_in_intr: error=0x04 { DriveStatusError }
[4294838.564000] ide: failed opcode was: unknown

this (with error 0x59 and 0x04) is repeated 3 more times, then: 

[4294838.699000] ide0: reset: success

but nothing change, and after a bit: 

[4294858.708000] hda: dma_timer_expiry: dma status == 0x21
[4294868.708000] hda: DMA timeout error
[4294868.712000] hda: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
[4294868.722000]
[4294868.724000] ide: failed opcode was: unknown
[4294868.729000] hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
[4294868.738000]
[4294868.740000] ide: failed opcode was: unknown
[4294868.746000] hda: drive not ready for command

(3 more times) 

[4294868.862000] ide0: reset: success

[4294888.879000] hda: dma_timer_expiry: dma status == 0x21

...and continuing forever (with error 0x58 as before). In the full log there
is a sysrq-m and sysrq-t result, but I do not think it's very important
here. 

When I decided to stop I hit sysrq-b and: 

[4294911.707000] SysRq : Resetting 

The bios (with the "sony" splash) restarted but locked hard, and to resume I
had to do the hard poweroff (5 seconds power button down). 


Well. I hope this helps someone :-). I will stay with S4 for now.

Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
