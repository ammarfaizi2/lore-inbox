Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbTI0Q5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 12:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTI0Q5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 12:57:40 -0400
Received: from web40907.mail.yahoo.com ([66.218.78.204]:8107 "HELO
	web40907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262508AbTI0Q5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 12:57:37 -0400
Message-ID: <20030927165736.63792.qmail@web40907.mail.yahoo.com>
Date: Sat, 27 Sep 2003 09:57:36 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Kernel panic:Unable to mount root fs (2.6.0-test5)
To: Jean-Marc Spaggiari <Jean-Marc@Spaggiari.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F75BF60.4000100@Spaggiari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Spaggari,

--- Jean-Marc Spaggiari <Jean-Marc@Spaggiari.org> wrote:
> Bradley Chapman wrote:
> 
> > 
> > 
> > Can you send more of the dmesg that comes from 2.6 when you try to boot it?
> > (i.e. send more lines of it than the last few)
> > 
> > 
> 
> Please, can you explain me how can I do that ? BEcause when I'm starting 
> with 2.6 kernel, it's hanging will starting, and when I'm starting with 
> 2.4.22 kernel, only informations about 2.4.22 is show by dmesg ...
> (If the 2.6 can't mounty the /, maybe it's why it can't write 
> information for dmesg on ?)

You're correct. What you've posted on the screen is exactly what I wanted,
thanks :)

> 
> Here is what I can see on the screen :
> 
> floppy0: no floppy controllers found
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> 8139too Fast Ethernet driver 0.9.26
> eth0: Realtek RTL8139 at 0xe3809f00, 00:08:0d:89:3c:38, IRQ 5
> mice: PS/2 mouse device common for all mice
> Synaptics Touchpad, model: 1
>   Firware: 5.9
>   Sensor: 15
>   ne absolute packet format
>   Touchpad has extended capability bits
>   -> multifinger detection
>   -> palm detection
> input: Synaptics TouchPad on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60, 0x64 irq 1
> NET: Registred protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> NET: Registerd protocol family 1
> VFS: Cannont open root device "302" or unknown-block(3,2)
> Please append a correct "root=" boot option
> Kernel panics: VFS: Unable to mount root fr onunknown-block(3,2)

I don't understand this "unknown-block" thing; I've never seen it before
on a 2.4 kernel. Grepping the source of a 2.6.0-test5-mm4 kernel, which is
what I use, shows that the "unknown-block" message comes from this function:

const char *__bdevname(dev_t dev, char *buffer)
{
	struct gendisk *disk;
	int part;

	disk = get_gendisk(dev, &part);
	if (disk) {
		buffer = disk_name(disk, part, buffer);
		put_disk(disk);
	} else {
		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
				MAJOR(dev), MINOR(dev));
	}

	return buffer;
}

Which is completely out of my league.

At this point I'd try 2.6.0-test5-mm4 (available at [www,ftp].kernel.org/pub/linux/
kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm4/2.6.0-test5-mm4.[bz2,gz])
or appeal to one of the Block Device Overlords, like Jens Axboe, for help.

> 
> That's all. I will try to modify the number of line of the screen in the 
> bis for seeing more information, but I can't promise anythinks ...
> 
> JMS.
> 

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
