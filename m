Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313268AbSDKIk2>; Thu, 11 Apr 2002 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313315AbSDKIk1>; Thu, 11 Apr 2002 04:40:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35854 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313268AbSDKIk0>; Thu, 11 Apr 2002 04:40:26 -0400
Message-ID: <3CB53D70.5070100@evision-ventures.com>
Date: Thu, 11 Apr 2002 09:38:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: More than 10 IDE interfaces
In-Reply-To: <20020411040845.GE14801@dark.x.dtu.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Baldur Norddahl wrote:
> Hi,
> 
> I have a machine with the following configuration:
> 
> 2 on board IDE interfaces (AMD chipset)
> 2 Promise Technology UltraDMA100 controllers with each 2 IDE interfaces.
> 4 Promise Technology UltraDMA133 controllers with each 2 IDE interfaces.
> 
> This adds up to 14 IDE interfaces. And I just discovered that the kernel
> only supports 10 IDE interfaces :-(
> 
> So I tried to hack the kernel, and I was partially successfull. I changed
> MAX_HWIF from 10 to 14. I made up some major numbers for the extra

In your case if should be changed to 15 there is an off by one error here in the
interpretation of this constant.

> interfaces (115, 116, 117 and 118).
> 
> drivers/ide/ide.c and fs/partitions/check.c were modified to know about
> IDE10_MAJOR to IDE13_MAJOR.
> 
> With there changes the kernel detects the extra interfaces and the disks on
> them. They get some strange names like IDE< and the last disk is named hd{,
> but I guess I can live with that :-)

The cause of those funny names is well known in the 2.5.xx series.
The solution to it will first involve a complete rewrite of the kernel
parameter parsing in ide.c

> 
> But when it tries to detect the partitions on the extra interfaces, it locks
> up. The last lines it writes is:
> 
> Partition check:
>  hda: hda1
>  hde: hde1
>  hdg: hdg1
>  hdi: hdi1
>  hdk: hdk1
>  hdm: hdm1
>  hdo: hdo1
>  hdq: hdq1
>  hds: hds1
>  hdu:

See above + make MAX_HWIFS 15 and you should have more luck. (Not tested
actually).


