Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSFGS0s>; Fri, 7 Jun 2002 14:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317314AbSFGS0r>; Fri, 7 Jun 2002 14:26:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46086 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317312AbSFGS0r>;
	Fri, 7 Jun 2002 14:26:47 -0400
Message-ID: <3D00FA43.2080809@mandrakesoft.com>
Date: Fri, 07 Jun 2002 14:24:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [PATCH][2.5] tulip: change device names
In-Reply-To: <Pine.LNX.4.44.0206071203580.15675-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:

>Hi,
>
>On Fri, 7 Jun 2002, Jeff Garzik wrote:
>  
>
>>Thanks for the effort, that was a quick turnaround :)
>>
>>But unfortunately the patch is wrong.
>>
>>You need to use an index which counts _tulip_ boards, which implies that 
>>the index is local to the driver.  Currently the only such counter is 
>>board_idx, which is a variable local to tulip_init_one().
>>    
>>
>
>Would you suggest
>
>a) setting it in some global struct (tulip_private etc.)?
>  
>


Yes, I would add "board_idx" member to struct tulip_private, and 
initialize it early in tulip_init_one()

Take care to update the printk's of only those functions which are 
actually called from tulip_init_one() before register_netdev().  All 
other references are correctly using dev->name.  "tulip%d" is only 
needed at startup.

    Jeff



