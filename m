Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSHWBWB>; Thu, 22 Aug 2002 21:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSHWBWA>; Thu, 22 Aug 2002 21:22:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33544 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318133AbSHWBWA>;
	Thu, 22 Aug 2002 21:22:00 -0400
Message-ID: <3D658F2C.1080400@mandrakesoft.com>
Date: Thu, 22 Aug 2002 21:26:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org>	<3D62BC10.3060201@mandrakesoft.com>	<3D62C2A3.4070701@mandrakesoft.com>	<m1sn17pici.fsf@frodo.biederman.org>	<3D656FDC.8040008@mandrakesoft.com> <m1ofbupfe1.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> The problem is that immediately after bootup ATA devices do not respond until
> their media has spun up.  Which is both required by the spec, and observed in
> practice.   Which is likely a problem if this code is run a few seconds after
> bootup.  Which makes it quite possible the drive will ignore the EXECUTE DEVICE
> DIAGNOSTICS and your error code won't be valid when the bsy flag
> clears.   I don't know how serious that would be. 


Well, this only applies if you are slack and letting the kernel init 
your ATA from scratch, instead of doing proper ATA initialization in 
firmware ;-)

Seriously, if you are a handed an ATA device that is actually in 
operation when the kernel boots, you are already out of spec.  I would 
prefer to barf if the BSY or DRDY bits are set, because taking over the 
ATA bus while a device is in the middle of a command shouldn't be 
happening at Linux kernel boot, ever.

	Jeff



