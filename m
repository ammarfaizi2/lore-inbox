Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314442AbSEIWqi>; Thu, 9 May 2002 18:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314443AbSEIWqh>; Thu, 9 May 2002 18:46:37 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:48876 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314442AbSEIWqg>; Thu, 9 May 2002 18:46:36 -0400
Date: Fri, 10 May 2002 00:46:15 +0200
From: Andi Kleen <ak@muc.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH & call for help: Marking ISA only drivers
Message-ID: <20020510004615.A1327@averell>
In-Reply-To: <20020509203719.A3746@averell> <3CDAD35A.6070900@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 09:51:54PM +0200, Martin Dalecki wrote:
> Uz.ytkownik Andi Kleen napisa?:
> >Hallo,
> >
> >This patch tries to make most ISA only drivers dependent on CONFIG_ISA. 
> 
> If only for the fact that it allows you to don't look at archaic
> hardware configuration options makes it a good idea I think.

And often the old drivers do not work anymore anyways...

> >The motivation is that it is a lot of work to get old drivers to compile
> >meaningfully (at least without warnings, not even testing them) on x86-64
> >and a lot of them are obviously not 64bit safe.  As it is very unlikely
> >that x86-64 boxes will ever have ISA slots[1] one simple way for that
> >is just removing the old ISA drivers from the configuration.
> >
> >BTW I think CONFIG_ISA would be an useful configuration option for 
> >i386 too - at least most modern PCs do not come with ISA slots anymore.
> 
> Plase add mcd and mcdx - CD-ROM drivers. Both of them required
> an special "controller" card, which was indeed ISA based.

I removed the complete drivers/cdrom directory for x86-64 now, as it seems to 
contain no PCI code at all. For i386 it can be made dependent on CONFIG_ISA.

Also I did this change for the IDE configuration (assuming that there 
are no boxes with no ISA but a VLB slot). I hope this covers all 
ISA/VLB only adapters for IDE.

You may want to incorporate it.

-Andi

--- linux/drivers/ide/Config.in-o	Mon May  6 13:11:47 2002
+++ linux/drivers/ide/Config.in	Thu May  9 20:42:45 2002
@@ -131,7 +131,8 @@
 	      EXT_DIRECT	CONFIG_IDE_EXT_DIRECT"	8xx_PCCARD
    fi
 
-   bool '  Other IDE chipset support' CONFIG_IDE_CHIPSETS
+   # assume no ISA -> also no VLB
+   dep_bool '  Other ISA/VLB IDE chipset support' CONFIG_IDE_CHIPSETS CONFIG_ISA
    if [ "$CONFIG_IDE_CHIPSETS" = "y" ]; then
       comment 'Note: most of these also require special kernel boot parameters'
       bool '    ALI M14xx support' CONFIG_BLK_DEV_ALI14XX
