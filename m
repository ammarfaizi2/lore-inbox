Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266919AbRGQS5s>; Tue, 17 Jul 2001 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266925AbRGQS5i>; Tue, 17 Jul 2001 14:57:38 -0400
Received: from ns.guardiandigital.com ([209.11.107.5]:10512 "HELO
	juggernaut.dmz.guardiandigital.com") by vger.kernel.org with SMTP
	id <S266919AbRGQS51>; Tue, 17 Jul 2001 14:57:27 -0400
Message-ID: <3B548A9A.2EA1DECA@guardiandigital.com>
Date: Tue, 17 Jul 2001 14:57:30 -0400
From: Nick DeClario <nick@guardiandigital.com>
Reply-To: nick@guardiandigital.com
Organization: Guardian Digital, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Passos <lists@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RAMDisk Blues
In-Reply-To: <Pine.LNX.4.30.0107170850030.19996-100000@intra.cyclades.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  I know there is this option in the kernel:

Default RAM disk size
CONFIG_BLK_DEV_RAM_SIZE
  The default value is 4096. Only change this if you know what are
  you doing. If you are using IBM S/390, then set this to 8192.

I grabbed that from ~/linux/Documentation/Configure.help.  I have never
gone about changing this before as the largest RAM disks I have delt
with were no larger than 3Mb.  But it defaults to 4Mb, so perhaps
increasing this would solve your problem.

	-Nick

Ivan Passos wrote:
> 
> Hello,
> 
> I'm trying to boot a Linux system that has the following configuration:
> - 32MB of Flash (IDE Flash Drive), where a kernel image and a compressed
>   root filesystem image are stored.
> - 256MB of RAM, 128MB of which will be used as a RAMDisk (believe me, this
>   is cheaper than 128MB Flash + 128MB RAM ... :).
> 
> After looking for information on how to do that on the 'Net and in the
> Documentation/ directory of the kernel src, I've been able make the Flash
> Drive bootable. Unfortunately, it's bootable, but it doesn't boot
> successfully ... :(
> 
> What I tried:
> - Compressed the image I used to boot the system from a regular IDE HD to
>   a file called rd_image.gz (~20MB compressed), and copied it to the IDE
>   Flash Drive.
> - Compiled a 2.4.6 kernel with RAMDisk and initrd support built-in, and
>   then copied it to the IDE Flash Drive.
> - Ran LILO with the following config. file (based on the doc. I found so
>   far):
> 
>         boot=/dev/hda           # The FlashDrive device
>         install=/boot/boot.b
>         map=/boot/map
>         append="ramdisk_size=131072 initrd=rd_image.gz"
>         vga=normal
>         default=Linux
>         delay=5
>         image=/boot/vmlinuz
>                 initrd=/boot/rd_image.gz
>                 root=/dev/ram0
>                 label=Linux
>                 read-only
> 
> LILO completes the operation without problems (no errors). However, when I
> boot the system from the FlashDrive, this is the output I get:
> 
> LILO Loading Linux ......................................................
> ..............................................
> 
> That's it!! The system hangs at this point (it really hangs, to the point
> that the "soft" power on/off doesn't work anymore, and I have to turn off
> the system from the back in order to reboot it).
> 
> What am I doing wrong?? Is my RAMDisk image too big (I thought there was
> no limit, as long as you had enough RAM ...)?? Does anyone here know a
> good resource on the 'Net where I can find more detailed information about
> creating a RAMDisk-based Linux system that boots from a device other than
> a floppy disk?? Most of the docs I found were related to boot / rescue /
> utility floppies, so I don't know whether this is the right way to do it
> or not ...
> 
> Any help would be appreciated.
> 
> Later,
> Ivan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Nicholas DeClario
Systems Engineer                            Guardian Digital, Inc.
(201) 934-9230                Pioneering.  Open Source.  Security.
nick@guardiandigital.com            http://www.guardiandigital.com
