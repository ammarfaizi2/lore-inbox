Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbULAWlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbULAWlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbULAWlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:41:52 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22197 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261497AbULAWiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:38:20 -0500
Message-ID: <41AE47F3.7090502@tmr.com>
Date: Wed, 01 Dec 2004 17:38:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cd burning, capabilities and available modes
References: <1101908433l.8423l.0l@werewolf.able.es>
In-Reply-To: <1101908433l.8423l.0l@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Hi...
> 
> Following my little oddisey to let cd-burning easy for my users,
> I think I have found another problem.
> 
> It looks like the formats available to cdrecord depend on being root
> (cdrecord is not suid, if it is it complains it cant reserve some
> buffers).
> 
> As root:
> 
> werewolf:/store/tmp# cdrecord -dummy dev=ATAPI:1,0,0 *.iso
> ...
> Device seems to be: Generic mmc2 DVD-R/DVD-RW.
> Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
> Driver flags   : MMC-3 SWABAUDIO BURNFREE 
> Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
> 
> As user:
> werewolf:/store/tmp> cdrecord -dummy dev=ATAPI:1,0,0 *.iso
> ...
> cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
> cdrecord: WARNING: This causes a high risk for buffer underruns.
> cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
> cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
> cdrecord: WARNING: This causes a high risk for buffer underruns.
> scsidev: 'ATAPI:1,0,0'
> devname: 'ATAPI'
> scsibus: 1 target: 0 lun: 0
> Warning: Using ATA Packet interface.
> Warning: The related Linux kernel interface code seems to be unmaintained.
> Warning: There is absolutely NO DMA, operations thus are slow.
> WARNING ! Cannot gain SYS_RAWIO capability ! 
> : Operation not permitted
> Using libscg version 'schily-0.8'.
> Device type    : Removable CD-ROM
> Version        : 0
> Response Format: 2
> Capabilities   : 
> Vendor_info    : 'HL-DT-ST'
> Identifikation : 'DVDRAM GSA-4120B'
> Revision       : 'A102'
> Device seems to be: Generic mmc2 DVD-R/DVD-RW.
> Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
> Driver flags   : MMC-3 SWABAUDIO BURNFREE 
> Supported modes: 
> cdrecord: Drive does not support TAO recording.
> cdrecord: Illegal write mode for this drive.
> 
> Uh ?
> 
> Some suggestions ?

I get that all the time, because one of my drives doesn't support TAO 
burning. I suspect your firmware sucks, and you will have to use session 
at a time rather than track at a time, option "-sao" works for me. Are 
you running standard cdrecord or one of the hacks?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
