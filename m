Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVECK44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVECK44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 06:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVECK4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 06:56:55 -0400
Received: from [195.23.16.24] ([195.23.16.24]:37778 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261449AbVECK4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 06:56:50 -0400
Message-ID: <427758BC.1090906@grupopie.com>
Date: Tue, 03 May 2005 11:55:56 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Greg KH <greg@kroah.com>, joecool1029@gmail.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Empty partition nodes not created (was device node issues with
 recent mm's and udev)
References: <d4757e6005050219514ece0c0a@mail.gmail.com>	<20050503031421.GA528@kroah.com> <20050502202620.04467bbd.rddunlap@osdl.org>
In-Reply-To: <20050502202620.04467bbd.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 2 May 2005 20:14:21 -0700 Greg KH wrote:
> 
> | On Mon, May 02, 2005 at 10:51:24PM -0400, Joe wrote:
> | > Ok, first off I'd like to say, I am on 2.6.12-rc3-mm2, and this issue
> | > is not fixed at all.  Secondly, I'd like to say that I've pinpointed
> | > it a bit more.  It appears only Empty partitions (type 0 in fdisk) do
> | > not create device nodes.
> | > 
> | > Here is the partition table from fdisk, fdisk does run fine.. its just
> | > the fact this node is not created that threw me off before.
> | > 
> | >    Device Boot      Start         End      Blocks   Id  System
> | > /dev/sdb1   *           1           2       16033+   0  Empty
> | > /dev/sdb2   *           6        2431    19486845    b  W95 FAT32
> | > /dev/sdb3               3           5       24097+  83  Linux
> | > 
> | > 
> | > Notice, /dev/sdb1 is a Empty partition... in /dev I only have sdb,
> | > sdb2, and sdb3.  No sdb1.  Any help would be appreciated.
> | 
> | Looks like it might be a scsi issue.  Redirecting to that mailing list
> | now.  Anyone here have a clue?
> 
> Could this 2.6.11.8 -stable patch fix it?
> Subject: [04/07] partitions/msdos.c fix
> 
> Joe, can you test 2.6.11.8, please?

It seems to me that this exactly the other way around. The patch is 
probably already in -mm and is doing what it is supposed to do: don't 
report partitions whose system ID == 0.

Can you try to give the empty partition a type different than zero? You 
don't need to make a file system on it or anything, just change the type.

Or check if the patch Randy is pointing to is already in your tree and 
revert it.

I think this is a good argument not to include this patch on the -stable 
release...

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
