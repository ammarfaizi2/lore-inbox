Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSFGRUc>; Fri, 7 Jun 2002 13:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316765AbSFGRUb>; Fri, 7 Jun 2002 13:20:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315919AbSFGRUb>;
	Fri, 7 Jun 2002 13:20:31 -0400
Message-ID: <3D00EAC3.7040903@mandrakesoft.com>
Date: Fri, 07 Jun 2002 13:17:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 tulip bogosities
In-Reply-To: <Pine.LNX.4.44.0206071103170.15675-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:

>Hi,
>
>On Thu, 6 Jun 2002, Mikael Pettersson wrote:
>  
>
>>Also note the obviously broken "eth%d" printk format string.
>>    
>>
>
>It's printk("%s: blah\n", dev->name);
>  
>

The "eth%d" thing is a format string, but unrelated to printk.  The %d 
is replaced with the ethernet interface number by the system.  That 
cosmetic bug is a holdover from olden days, when the ethernet interfaces 
would do

    register ethernet interface, get a number
    if we fail, release the number

So with the old system, it's possible that the user might be

    eth0: error cannot load, aborting [first NIC]
    eth0: error cannot load, aborting [second NIC]
    eth0: error cannot load, aborting [third NIC]

The new system, which is hotplug-friendly, makes it impossible to know 
the ethernet interface number until you _really_ are sure the NIC is ok 
to use.  Therefore, "eth%d" is "dev->name" that has not been translated 
yet.  The fix is simple, replace "eth%d" with "tulip%d" in the printk 
message, and use the board count instead of ethernet interface number.

    Jeff





