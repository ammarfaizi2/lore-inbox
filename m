Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbTBEU6y>; Wed, 5 Feb 2003 15:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBEU6y>; Wed, 5 Feb 2003 15:58:54 -0500
Received: from [216.150.199.16] ([216.150.199.16]:55982 "EHLO mail.aspsys.com")
	by vger.kernel.org with ESMTP id <S264885AbTBEU6w>;
	Wed, 5 Feb 2003 15:58:52 -0500
Subject: Re: How to install two linux OSes on the same PC
From: Dave Vehrs <davidv@aspsys.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3E418AD0.BC9F9765@npd.hcltech.com>
References: <3E418AD0.BC9F9765@npd.hcltech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Feb 2003 14:10:55 -0700
Message-Id: <1044479456.1431.23.camel@DV-Laptop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 15:06, Narsimha Reddy CHALLA wrote:
>     I want to do two different linux installations rh 7.2 and rh 
> 8.0 on the same pc with single hard disk. I installed the rh 7.2 in
> partitions say  /dev/hda5 ( /) ,  /dev/hda6  (/home) ,  /dev/hda7 (
> /usr) ,/dev/hda8 ( /tmp),... /dev/hda11  etc. 
> 
>    But how can I install the rh 8.0 in partitions say  /dev/hda12
> ( as "/" )  ... etc ??  Since the installer won't allow as there
> already exists a  "/"  partition for the rh 7.2 and tries to override
> it with the root partition of rh 8.0. So I tried giving a different
> lable to the root partition of rh 8.0 say /root1 and other partitions
> as /root1/usr, /root1/home, /root1/tmp etc. But here also the installer
> is looking for the partition named "/" and without that the installation
> is not happening. 

I believe the problem is related to Redhat's use of partition labels
by default on 7.x and 8.x.   Makes it easy if the drives master/slave 
changes but causes problems for other things like this.  

For example, my /etc/fstab looks like: 
LABEL=/        /            ext3    defaults        1 1
LABEL=/boot    /boot        ext2    defaults        1 2
LABEL=/home    /home        ext3    defaults        1 2
/dev/hda3      swap         swap    defaults        0 0
/dev/cdrom     /mnt/cdrom   iso9660 noauto,owner,kudzu,ro 0 0

Attempting to boot a system with two drives (or multiple partitions on
the same drive) configured like this will confuse the system.  So the
first step would be to change the LABEL= lines to /dev/<device>  (i.e.
/dev/hda1      /boot ......etc.)

Next issue is how you want to boot the two systems.  One boot partition
or two?  With one boot, make a copy of what is already there, then
install the new system, allowing it to overwrite the old.  Then merge
the two boot partitions by hand.  They will already be a different
kernels, etc. so it shouldn't be too hard.  

Then I would recommend booting the second system or mounting its drives
in the first temporarily and making similar changes to its fstab that we
did to the first.  

Then reboot and I believe it should work....

Good luck,

Dave V.

-- 
David E Vehrs, System Engineer		Aspen Systems
davidv@aspsys.com			3900 Youngfield Street
Tel: +01 303 431 4606			Wheat Ridge CO 80033, USA
Fax: +01 303 431 7196			http://www.aspsys.com

