Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTF0CpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTF0Co5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:44:57 -0400
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:17026
	"EHLO ori.thedillows.org") by vger.kernel.org with ESMTP
	id S263496AbTF0CoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:44:23 -0400
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
From: David Dillow <dave@thedillows.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1056663251.3172.7.camel@dhcp22.swansea.linux.org.uk>
References: <1056493150.2840.17.camel@ori.thedillows.org>
	 <20030624204828.I30001@newbox.localdomain>
	 <1056513292.3885.2.camel@ori.thedillows.org>
	 <1056557323.1444.4.camel@dhcp22.swansea.linux.org.uk>
	 <1056597452.2732.4.camel@ori.thedillows.org>
	 <1056663251.3172.7.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056682712.2610.18.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jun 2003 22:58:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-26 at 17:34, Alan Cox wrote:
> On Iau, 2003-06-26 at 04:17, David Dillow wrote:
> > Trace; c01de899 <idescsi_reset+29/80>
> > Trace; c01d891d <scsi_reset+11d/370>
> 
> Interesting trace.
> 
> Lets try a little sanity check first then. Replace that whole 
> idescsi_reset handler with "return SCSI_RESET_SNOOZE"

With that change, I've burned two disks back to back with no oopsen.

All I get in the logs are these (expected) messages:
scsi : aborting command due to timeout : pid 522, scsi0, channel 0, id
0, lun 0
scsi : aborting command due to timeout : pid 522, scsi0, channel 0, id
0, lun 0
SCSI host 0 abort (pid 522) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 522) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 144056, scsi0, channel 0,
id 0, lu
scsi : aborting command due to timeout : pid 144056, scsi0, channel 0,
id 0, lu
SCSI host 0 abort (pid 144056) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 144056) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.

Don't know if you broke anything else, but I can burn with magicdev
running and it not lock up the system now.

I've got four pieces of this media left, so if you want me to test the
next iteration of the patch, give me a yell.

Thanks,
Dave


