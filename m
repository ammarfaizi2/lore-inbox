Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTLDA75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTLDA74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:59:56 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:7387 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262787AbTLDA7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:59:51 -0500
Message-ID: <3FCE86ED.8070601@rackable.com>
Date: Wed, 03 Dec 2003 16:59:25 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andre Tomt <lkml@tomt.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <1070494030.15415.111.camel@slurv.pasop.tomt.net> <3FCE737C.1080105@pobox.com>
In-Reply-To: <3FCE737C.1080105@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2003 00:59:49.0141 (UTC) FILETIME=[EAAC7450:01C3BA01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andre Tomt wrote:
> 
>> On Wed, 2003-12-03 at 21:44, Jeff Garzik wrote:
>>
>>> Intel ICH5
>>> ----------
>>> Summary:  No TCQ.  Looks like a PATA controller, but with a few added,
>>> non-standard SATA port controls.
> 
> 
>> One question - with "including hotplug", does that mean some set hotplug
>> standard? Reason I'm asking is, we have a few servers from SuperMicro,
>> with a ICH5R S-ATA controller that claims it's supporting hotplug, but
>> hotplug is not in your ICH5-summary.
> 
> 
> Alas, there is no hotplug support in the ICH5 or ICH5-R SATA hardware.
> 
> One could argue there is "coldplug" support in that hardware -- disable 
> the entire interface, including any active devices, then re-enable and 
> re-scan -- but it's a bit of a hack.  If there's enough demand, I could 
> write some code for that.  It would involve something like
> 
>     # /sbin/sata off
>     { plug in or remove a device }
>     # /sbin/sata on
> 
> You really, really, really don't want to actually unplug a SATA drive 
> while it's active, on ICH5 hardware.
>

   In theroy the scsi driver allows you kill a drive, and do rescan by 
echoing to /proc/scsi.scsi.  I know it worked under 2.4 with sca drive 
on a hotswap backplane.  This was over a year ago.  So it may have been 
broken.

scsi.c:
  * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
          * with  "0 1 2 3" replaced by your "Host Channel Id Lun".


         /*
          * Usage: echo "scsi remove-single-device 0 1 2 3" >/proc/scsi/scsi
          * with  "0 1 2 3" replaced by your "Host Channel Id Lun".
          *

PS-  Yes I know says it isn't for hotswap, and that it's prebeta.  This 
comment dates back to at least 2.2.  It's worked for least 4 years.
-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

