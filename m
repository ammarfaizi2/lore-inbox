Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbTGLQqO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbTGLQqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:46:14 -0400
Received: from cherryhinton.org.uk ([194.106.52.201]:46181 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S266114AbTGLQqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:46:12 -0400
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Reply-To: Ruth.Ivimey-Cook@ivimey.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached to fix
Date: Sat, 12 Jul 2003 18:01:03 +0100
User-Agent: KMail/1.5.2
Cc: Samuel Flory <sflory@rackable.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       Steven Dake <sdake@mvista.com>, <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0307121754050.19333-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307121754050.19333-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121801.03776.ruth@ivimey.org>
X-Spam-Score: -1.6 (-)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 Jul 2003 5:14 pm, Bartlomiej Zolnierkiewicz wrote:
> I think you just need "pdc_ide=0,force" and "pdc_ide=0,noforce".
> No need to complicate things.
> Remember that ataraid is only software RAID driver and pdc202xx_new
> is a chipset driver.

I am not forgetting, but I don't like this idea of 'force' -- it instantly 
raises the question 'force what' and then you're in the quagmire again.

Better to tell the kernel what you want and let the kernel worry about how to 
make it happen.

So the "pdc_ide2=jbod"  would be scanned and interpreted as a request to 
activate ('force') the drive into IDE mode and not enable any ataraid (jbod 
==> just disks),

while "pdc_ide3=promise" would let the drive state be, and make the kernel do 
a "modprobe promise-ft" (or whatever it's called) to load the rest of the 
driver, as is done for 'scsi-hostadapter'. [Would you ever have to force a 
promise chip into promise-raid mode?].

Do you see what I mean?

If you prefer, the string could be "pdc=ide2:ide, ide3:ataraid".

> jbod/raid should be managed by ataraid driver not ide or pdc202xx_new.

I was using jbod as just that, not as meaning raid-0 or similar. Perhaps I 
should have been clearer. So you've a choice of (just IDE), (RAID via 
ataraid) and (RAID via Promise)

> And seriously, I don't care unless somebody ports ataraid to 2.5.
> [ Hint, hint! ;-) ]

Hint understood and I'll look, but I'm no kernel guru. 

> > Should I think about coding this?
>
> No, think about porting ataraid and pdcraid to 2.5 first.

pdcraid == ataraid module for PDC?? Haven't looked at the src yet.

Regards,

Ruth


-- 
Engineer, Author and Webweaver

