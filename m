Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263722AbUD0Dgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUD0Dgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUD0Dgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:36:43 -0400
Received: from [203.105.59.85] ([203.105.59.85]:9974 "EHLO mail.mailprove.com")
	by vger.kernel.org with ESMTP id S263722AbUD0Dge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:36:34 -0400
Message-ID: <408DD535.80507@mailprove.com>
Date: Tue, 27 Apr 2004 11:36:21 +0800
From: Seve Ho <sho@mailprove.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arthur Perry <kernel@linuxfarms.com>, linux-kernel@vger.kernel.org
Subject: Re: mkinitrd error
References: <408CDBF1.90301@mailprove.com> <Pine.LNX.4.58.0404261005210.8600@tiamat.perryconsulting.net>
In-Reply-To: <Pine.LNX.4.58.0404261005210.8600@tiamat.perryconsulting.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help and sorry for asking the Redhat question here...
I will tried out the solutions you provided today later.

However, I would like to ask one more question about compiling kernel ( 
I sure this is about the kernel this time.)

The following is what I does to recompile my kernel, I run these command 
at /usr/src/linux-2.4/

 # make mrproper
 # cd /usr/src/linux-2.4/configs
 # cp kernel-2.4.18-ia64-smp.config  /usr/src/linux-2.4/.config
 # make oldconfig
 # make dep
 # make compressed
 # make modules
 # make modules_install
 # make install 

All the steps went good but when it comes to "make install", the error 
happened
   
    make: *** No rule to make target `install'.  Stop.

Does that means I dont have the any code in the "Makefile" for "make 
install"? And does that means my Makefile is not correct?
I have looked into the web and some documents said make install will 
copy the kernel file to correct directory and make a new entry into 
elilo.conf.

Based on this, could I manually do the following instead of relying on 
the "make install" command?

1. copy the kernel files (vmlinux.gz and System.map) to 
/boot/efi/efi/redhat/
2. make symbolic link to above file at /boot
3. edit elilo.conf to add a new entry pointing to the new kernel compiled.
4. Restart.

Could anyone provide opinions on it?
Thanks again.

Seve





Arthur Perry wrote:

>Hi Steve,
>
>You probably want to communicate this back to RedHat. (I assume you are
>using RedHat)..
>I have seen the same thing, but honestly did not take it too seriously.
>I figured someone else would report it to them ;)
>
>The mkinitrd script is located at /sbin/mkinitrd.
>It creates a fixed-size ramdisk at 4000 kbytes if i386, and 8000 kbytes
>for "all" other architectures (or more accurately, other architectures
>that would see this specific script) .. That would be ia64.
>For a quick fix, you can change this value to something larger like 12000.
>This should fit what you need.
>Just change line 45 from "IMAGESIZE=8000" to "IMAGESIZE=12000".
>You now can re-run it and it should complete without errors.
>
>Then you will need to modify your elilo.conf file, passing the new
>ramdisk size to the kernel command line.
>This has to be done because the new ramdisk size is larger than the
>default value which the kernel expects.
>
>Simply find your active kernel paragraph in the
>/boot/efi/efi/redhat/elilo.conf file, and make sure your append line
>reads,
>append="root=LABEL=/ ramdisk_size=12000"
>
>Off the top of my head, I think this is all you need to do.
>
>FYI, correct me if I am wrong everyone, but this really should go to a
>RedHat support mail group. Not the kernel development one.
>It was just a free ticket and I am just having my morning coffee ;)
>
>Arthur Perry
>Lead Linux Developer / Linux Systems Architect
>Validation, CSU Celestica
>Sair/Linux Gnu Certified Professional, 2000
>Project Manager, Linuxfarms
>http://www.linuxfarms.com
>
>
>
>On Mon, 26 Apr 2004, Seve Ho wrote:
>
>  
>
>>Hi,
>>
>>I am trying to recompile kernel on Itanium2 Redhat box.( This is my
>>first time to do it and actually I am new to Linux )
>>After recompilation, I tried to create initial ramdisk with mkinitrd.
>>However, it failed with following error messages...
>>Does anyone have idea about what is jdb? And how can i make the ramdisk
>>successfully?
>>
>>Any help  or hints will be greatly appreciated.( I am not on the list,
>>could you kindly cc your answer or suggestion to sho@mailprove.com ? )
>>
>>
>>Seve
>>
>>
>>[root@SDV900 root]# mkinitrd -v initrd-2.4.18-e.31custom20040426.img
>>2.4.18-e.31custom20040426
>>Using modules:  ./kernel/drivers/scsi/scsi_mod.o
>>./kernel/drivers/scsi/sd_mod.o
>>./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx_2.o ./kernel/fs/jbd/jbd.o
>>./kernel/fs/ext3/ext3.o
>>Using loopback device /dev/loop0
>>/sbin/nash -> /tmp/initrd.naSZEa/bin/nash
>>/sbin/insmod.static -> /tmp/initrd.naSZEa/bin/insmod
>>`/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/scsi_mod.o'
>>-> `/tmp/initrd.naSZEa/lib/scsi_mod.o'
>>`/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/sd_mod.o'
>>-> `/tmp/initrd.naSZEa/lib/sd_mod.o'
>>`/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx_2.o'
>>-> `/tmp/initrd.naSZEa/lib/sym53c8xx_2.o'
>>`/lib/modules/2.4.18-e.31custom20040426/./kernel/fs/jbd/jbd.o' ->
>>`/tmp/initrd.naSZEa/lib/jbd.o'
>>`/lib/modules/2.4.18-e.31custom20040426/./kernel/fs/ext3/ext3.o' ->
>>`/tmp/initrd.naSZEa/lib/ext3.o'
>>Loading module scsi_mod
>>Loading module sd_mod
>>Loading module sym53c8xx_2
>>Loading module jbd
>>Loading module ext3
>>*tar: ./lib/jbd.o: Wrote only 0 of 10240 bytes
>>tar: Skipping to next header
>>tar: Error exit delayed from previous errors*
>>
>>--
>>Seve Ho
>>Programmer
>>
>>Tel   (852) 3105 2920
>>Fax   (852) 3105 2926
>>Email Seve.Ho@MailProve.com
>>
>>
>>Mail Prove Ltd.
>>806, Cyberport 1
>>100 Cyberport Rd.
>>Pokfulam, H. K.
>>
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>

-- 
Seve Ho
Programmer

Tel   (852) 3105 2920
Fax   (852) 3105 2926
Email Seve.Ho@MailProve.com


Mail Prove Ltd.
806, Cyberport 1
100 Cyberport Rd.
Pokfulam, H. K. 




