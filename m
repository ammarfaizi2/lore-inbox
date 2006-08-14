Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWHNVPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWHNVPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWHNVPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:15:54 -0400
Received: from smtp19.orange.fr ([80.12.242.1]:59233 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S964915AbWHNVPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:15:48 -0400
X-ME-UUID: 20060814211546476.7446B1C00082@mwinf1916.orange.fr
Message-ID: <44E0E800.1050000@wanadoo.fr>
Date: Mon, 14 Aug 2006 23:15:44 +0200
From: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       darkhack@gmail.com, reinaldoc@gmail.com
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on
 unknown-block
References: <44DFCF20.9030202@wanadoo.fr> <44E07B36.6070508@gmail.com> <44E08C50.5070904@wanadoo.fr>
In-Reply-To: <44E08C50.5070904@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In progress ! I built-in LVM driver and compile the kernel with the 
-initrd option. I have not more the kernel panic message, but I have a 
lot of errors than this :

I/O error ; hda: cannot handle device with more than 16 heads - giving up


I'm astonished, I believed that old .config was operational with a new 
kernel (my old was a 2.6.16, the new, 2.6.17).

Regards,
Thibaud.

Hulin Thibaud a écrit :
> Sorry, new kernel is 2.6.17. to install suspend2.
> I believe using LVM, but I'm not sure.
> In effect, initrd is not present ! I rode this lines in my menu.lst :
> title        Ubuntu, kernel 2.6.171915
> root        (hd1,4)
> kernel        /boot/vmlinuz-2.6.171915 root=/dev/hdb5 ro quiet splash
> savedefault
> boot
> 
> So, I suppose that's the center of the problem, but actually, I don't 
> know how to solve it.
> 
> Nick Manley a écrit :
>  > I think you meant 2.6.18?  Anyways, I'm not expert but I usually have
>  > problems when using oldconfig.  It seems you have your kernel settings
>  > configured properly and have included all the proper stuff (ext3, ide
>  > drivers) to be built in.  I would try disabling SCSI if you aren't
>  > using it.  Another thing to look at would be your settings in GRUB (or
>  > lilo).  Your particular setup might vary but it should look something
>  > like this...
>  >
>  > title Linux 2.6.18
>  > root (hd0,2)
>  > kernel /boot/bzImage-2.6.18 root=/dev/hda3 ro
>  > # you might also have an "initrd" placed here
>  >
>  > If you search Google you can find other suggestions as well and also
>  > posting to your distribution's forum might be a good idea too as the
>  > kernel mailing list is usually a place for reporting bugs and
>  > discussing kernel development.  Basically it is a last resort kind of
>  > thing if you can't find the information anywhere else.
>  >
>  > On 8/13/06, Hulin Thibaud <hulin.thibaud@wanadoo.fr> wrote:
>  >> Hello !
>  >> I'm trying to compile my own kernel for drivers on two computers, but
>  >> that fails. A the boot, I have this error :
>  >> kernel panic - not syncing: VFS Unable to mount root fs on unknow-block
>  >> (3.69)
>  >>
>  >> I'm using the kernel 2.6.19 with Ubuntu Dapper. I use the old boot
>  >> config and I type make oldconfig, so I don't understand why there 
> are an
>  >> error with the near same configuration.
>  >> I suppose that I must compile not in module but in hard support for my
>  >> IDE chipset, harddisk and file system. Probably, I don't understand how
>  >> do exactly. I do that :
>  >> lspci |grep IDE
>  >> 0000:00:11.1 IDE interface: VIA Technologies, Inc.
>  >> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
>  >> make xconfig
>  >> -Device Drivers
>  >> --* ATA/ATAPI/MFM/RLL support
>  >> --- * Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
>  >> --- * Include IDE/ATA-2 DISK support
>  >> --- * PCI IDE chipset support
>  >> ---- * Generic PCI IDE Support
>  >> ----- * VIA82CXXX chipset support
>  >> - File systems
>  >> -- * Ext3 journalling file system support
>  >> --- * Ext3 extended attributes
>  >> ---- * Ext3 POSIX Access Control Lists
>  >> ---- * Ext3 Security Labels
>  >>
>  >> Have I forgot anything ?
>  >>
>  >> Thanks very much,
>  >> Thibaud.
>  >> -
>  >> To unsubscribe from this list: send the line "unsubscribe
>  >> linux-kernel" in
>  >> the body of a message to majordomo@vger.kernel.org
>  >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  >> Please read the FAQ at  http://www.tux.org/lkml/
>  >>
>  >
>  >
> 
> 
> 
> 
> Jiri Slaby a écrit :
>> Hulin Thibaud wrote:
>>> Hello !
>>> I'm trying to compile my own kernel for drivers on two computers, but 
>>> that fails. A the boot, I have this error :
>>> kernel panic - not syncing: VFS Unable to mount root fs on 
>>> unknow-block (3.69)
>>>
>>> I'm using the kernel 2.6.19 with Ubuntu Dapper. I use the old boot 
>>
>> Wow, 2.6.18 wasn't released yet and you have 2.6.19, cool.
>>
>>> config and I type make oldconfig, so I don't understand why there are 
>>> an error with the near same configuration.
>>> I suppose that I must compile not in module but in hard support for 
>>> my IDE chipset, harddisk and file system. Probably, I don't 
>>> understand how do exactly. I do that :
>>> lspci |grep IDE
>>> 0000:00:11.1 IDE interface: VIA Technologies, Inc. 
>>> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
>>> make xconfig
>>> -Device Drivers
>>> --* ATA/ATAPI/MFM/RLL support
>>> --- * Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
>>> --- * Include IDE/ATA-2 DISK support
>>> --- * PCI IDE chipset support
>>> ---- * Generic PCI IDE Support
>>> ----- * VIA82CXXX chipset support
>>> - File systems
>>> -- * Ext3 journalling file system support
>>> --- * Ext3 extended attributes
>>> ---- * Ext3 POSIX Access Control Lists
>>> ---- * Ext3 Security Labels
>>>
>>> Have I forgot anything ?
>>
>> RAID or LVM? Try initrd.
>>
>> regards,
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

