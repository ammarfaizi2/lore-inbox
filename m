Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWCUQCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWCUQCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWCUQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:02:12 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:43791 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751809AbWCUQCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:02:11 -0500
Message-ID: <4420236F.80608@lougher.demon.co.uk>
Date: Tue, 21 Mar 2006 16:01:51 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
Reply-To: Pavel Machek <pavel@ucw.cz>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Jeff Garzik <jeff@garzik.org>, Phillip Lougher <phillip@lougher.org.uk>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz>
In-Reply-To: <20060319163249.GA3856@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Fri 17-03-06 12:25:44, Jeff Garzik wrote:
>>I have two routers, ADM5120-based Edimax and LinkSys 
>>WRT54G v5, both of which have a mere 2MB of flash, and 
>>both use SquashFS to maximize that space.  And both are 
>>el cheapo, slow embedded processors that run far slower 
>>than 300Mhz.  I look askance at anyone who wants to make 
>>an arbitrary filesystem design decision imposing tons of 
>>bytesex upon these lowly devices.
> 
> 
> gzip is already pretty expensive, I'd say. Is not byteswap lost in
> noise?
>

Perhaps, but almost all the byteswap is performed on the metadata side, 
reading directories and inodes, where nearly every byte will need to be 
swapped.  As inodes are compacted and compressed in 8 KB blocks, and are 
on average 15 bytes in size, for each 8 KB decompress you're potentially 
doing 8192/15 inode byteswaps.  This is probably sufficent to affect 
directory search and lookup on a slow processor.

The data path is all gzip overhead (64K datablocks), there is no 
byteswap taking place except for the block size integer.  Therefore 
byteswap doesn't have any affect on reading data.

Phillip
