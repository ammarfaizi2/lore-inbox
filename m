Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTIVNkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbTIVNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:40:24 -0400
Received: from barclay.balt.net ([195.14.162.78]:38843 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S263148AbTIVNkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:40:19 -0400
Date: Mon, 22 Sep 2003 17:36:05 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm4
Message-ID: <20030922143605.GA9961@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <200309221317.42273.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309221317.42273.alistair@devzero.co.uk>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 01:17:42PM +0100, Alistair J Strachan wrote:
> On Monday 22 September 2003 09:35, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2
> >.6.0-test5-mm4/
> >
> >
> > . A series of patches from Al Viro which introduce 32-bit dev_t support
> >
> > . Various new fixes
> >
> >
> 
> Hi Andrew,
> 
> -mm4 won't mount my ext3 root device whereas -mm3 will. Presumably this is 
> some byproduct of the dev_t patches.
> 
> VFS: Cannot open root device "302" or hda2.
> Please append correct "root=" boot option.
> Kernel Panic: VFS: Unable to mount root fs on hda2.

Do you use devfsd ? 

I had to specify root like this :
root=/dev/ide/host0/bus0/target0/lun0/part5  then it worked just fine.

Btw Andrew ,

this change  "Synaptics" -> "SynPS/2" - breaks driver synaptic driver
from http://w1.894.telia.com/~u89404340/touchpad/index.html. 


-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/
2", "ImPS/2", "ImExPS/2", "Synaptics"}; 
+static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};


> 
> One possible explanation is that I have devfs compiled into my kernel. I do 
> not, however, have it automatically mounting on boot. It overlays /dev (which 
> is populated with original style device nodes) after INIT has loaded.
> 
> Perhaps there is some other procedure I must complete before I can use 32bit 
> dev_t?
> 
> [alistair] 01:15 PM [/usr/src/linux-2.6] egrep -e "DEVFS" -e "EXT3_FS" .config
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_DEVFS_FS=y
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> 
> [alistair] 01:16 PM [/usr/src/linux-2.6] dmesg | grep p2
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p4
> 
> Cheers,
> Alistair.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
