Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWBGL3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWBGL3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWBGL3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:29:07 -0500
Received: from sccrmhc13.comcast.net ([204.127.200.83]:47554 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964833AbWBGL3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:29:05 -0500
Message-ID: <43E88480.1010303@comcast.net>
Date: Tue, 07 Feb 2006 06:29:04 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
References: <20060207084347.54CD01430C@rhn.tartu-labor> <1139310335.18391.2.camel@localhost.localdomain> <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:

>> Very strange trace indeed. I'll take a look at this. At least since it
>> came from Qemu I should be able to "build" a suitable PC to match yours.
>>
>> Original Intel PIIX devices are handled by "OLDPIIX" (0x8086, 0x1230).
>> The later ones by ata_piix. The only oddity I see is that you have no
>> PCI bus mastering address base assigned (bmdma)
>
>
> I also tried VMWare 5.5 that emulated PIIX4. It works if I only put 
> ata_piix driver in. With the same kernel that Qemu gets the error, 
> VMWare gets another oops during generic ide initialisation. I relooked 
> and found that I have both generic PCI ide and generic ISA ide drivers 
> compiled in, so I disabled them and it works using ata_piix (with PATA 
> and ATAPI enabled). Even ATAPI cdrom worked as the root partition.
>
> But, the different oops that I got in vmware with generic ide:
> http://www.cs.ut.ee/~mroos/atacrash.png
>
I was under the impression that libata pata and ide drivers are mutually 
exclusive.  You're not  supposed to be using both at the same time 
unless they're for completely different controllers.

Maybe this should be in the config to auto unselect the other equivilant 
driver (+generic) when either the libata or ide one is user selected, or 
at least mentioned in the help for future testers.

Since libata is loaded after regular ide, having generic ide compiled in 
is a problem.  Generic drivers should be loaded after all specific 
compiled in drivers and generic libata should override generic ide.  
This seems to be very complicated if both interfaces are to be around at 
the same time for a while.   Maybe it should just be mentioned in the 
Help for libata drivers  that it's best to just disable all regular ide 
drivers when using libata pata ones.
