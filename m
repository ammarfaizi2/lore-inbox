Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUIWTZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUIWTZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUIWTZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:25:42 -0400
Received: from hadar.amcc.com ([192.195.69.168]:29616 "EHLO hadar.amcc.com")
	by vger.kernel.org with ESMTP id S266491AbUIWTZh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:25:37 -0400
From: "Adam Radford" <aradford@amcc.com>
To: Glenn Johnson <gjohnson@srrc.ars.usda.gov>
CC: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
Date: Thu, 23 Sep 2004 12:24:43 -0700
Organization: AMCC
X-Sent-Folder-Path: Sent Items
X-Mailer: Oracle Connector for Outlook 9.0.4 51114 (9.0.6627)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <I4IDYU01.T3M@hadar.amcc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn,

proc_info support is being removed from scsi drivers _right now_.
There are other instances of this happening:

http://marc.theaimsgroup.com/?l=bk-commits-head&m=109372835112734&w=2

Furthermore, no changes to this interface are being accepted.

This probably should have happened in 2.7, but there is no 2.7 tree,
as 2.6.8.1 is the stable kernel and -mm is the development tree.

There was so much dead code in the 3w-xxxx driver that it needed a major
facelift for 2.6.  Otherwise it would eventually have been marked broken.
As a part of the facelift, you must update your tools.  Nobody can guarantee
future proofness of userspace tools that access low level kernel ioctls, 
/proc entries, /sysfs entries, etc.  As the kernel changes, drivers change,
and therefore userspace tools also change.  If you don't want to upgrade
your tools, don't upgrade your kernel.  The driver changes in the -mm tree
are not likely to make it into the mainline till 2.6.10 final.  In the meantime
you can run 2.6.8.1 or drop the changes for 3w-xxxx from the -mm patch if you 
really need to run it.

3dm2 and the new tw_cli also support 7000 & 8000 controllers, however you need 
the In-Engineering Developement (Pre 9.1) tools release since they do part of their 
controller detection through the new sysfs attributes in the newer 3w-xxxx driver.  
If you don't want to get the pre-release tools, wait till the 9.1 release comes out, 
and the 3dm2 and tw_cli in that release will work for you.

-Adam

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Glenn Johnson
> Sent: Thursday, September 23, 2004 10:55 AM
> To: Adam Radford
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
> 
> 
> On Thu, 2004-09-23 at 12:32, Adam Radford wrote:
> 
> > Glenn,
> > 
> > The /proc/scsi interface is being deprecated by the SCSI 
> subsystem maintainers.
> 
> I am aware of that.  I also thought the interface would remain until
> third party vendors had a chance to catch up.
> 
> > Support for /proc/scsi/3w-xxxx has been removed from the 
> driver and sysfs support
> > has been added. 
> 
> Is is possible to have it support both?
> 
> > Please download the newer 3dm2 tools from the 3ware software
> > "In-Engineering Development" website, or, keep your older 
> kernel and tools.
> 
> I am not sure what the "In-Engineering Development" website is but the
> "regular" 3ware Web site only offers 3dm2 for the 9000 series
> controllers, which I do not have.  I suppose I could just try 
> it though.
>   
> > If you have any more questions, please contact 3ware/AMCC support.
> 
> I do not know what AMCC brings to the table but I have never gotten
> answers from 3Ware support.
> 
> > -Adam
> > 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of 
> Glenn Johnson
> > Sent: Thursday, September 23, 2004 9:09 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
> > 
> > 
> > I have a 3Ware-7500 series card.  I was trying the 
> 2.6.9-rc2-mm2 kernel
> > and discovered that the 3dmd utility was not working.  A 
> little poking
> > around revealed that the cause was because the 3Ware 
> directory was not
> > in /proc/scsi, even though I have CONFIG_SCSI_PROC_FS=y in my config
> > file.  The 3dmd utility works fine with mainline 2.6.9-rc2 
> and it worked
> > with the 2.6.8-mm series of kernels.  Those kernels have a 3w-xxxx
> > directory in /proc/scsi.
> > 
> > Thanks.
> -- 
> Glenn Johnson
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

