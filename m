Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVIHWVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVIHWVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVIHWVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:21:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27380 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965038AbVIHWVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:21:36 -0400
Message-ID: <4320A372.1040801@mvista.com>
Date: Thu, 08 Sep 2005 13:47:46 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] KGDB for Real-Time Preemption systems
References: <20050811110051.GA20872@elte.hu> <200509071055.54016.Serge.Noiraud@bull.net> <431F58C8.70109@mvista.com> <200509081057.54005.Serge.Noiraud@bull.net>
In-Reply-To: <200509081057.54005.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> mercredi 7 Septembre 2005 23:16, George Anzinger wrote/a écrit :
> 
>>Serge Noiraud wrote:
> 
> ...
> 
>>>I'm trying this kgdb patch with 2.6.13 and I get the following errors.
>>>Is there something I forgot ?

Where did you get the kgdb you are using?  It looks like kgdb_ts is in 
this version, but it it not in the one on my website 
http://source.mvista.com/~ganzinger/
>>
>>This related to kgdb?  I.e. does it go away if you either turn off kgdb
>>at configure time or just don't patch with kgdb?  (It sure seems
>>unrelated, but...)
> 
> I don't get those errors with CONFIG_KGDB=n
> bellow I put the diff between a working . config and a non working .config
> 
>>George
>>
>>
>>>...
>>>  INSTALL sound/usb/snd-usb-audio.ko
>>>  INSTALL sound/usb/snd-usb-lib.ko
>>>  INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
>>>if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
>>>System.map -b /var/tmp/kernel-2.6.13-rt4-root -r 2.6.13-rt4; fi
>>>WARNING:
> 
> ...
> If I redo the make command only ( not make rpm ) I obtain the following :
> # make
>   CHK     include/linux/version.h
> make[1]: « arch/i386/kernel/asm-offsets.s » est à jour.
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
> Kernel: arch/i386/boot/bzImage is ready  (#1)
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "preempt_locks" [net/sunrpc/sunrpc.ko] undefined!
> *** Warning: "preempt_locks" [net/appletalk/appletalk.ko] undefined!
> *** Warning: "preempt_locks" [fs/reiserfs/reiserfs.ko] undefined!
> *** Warning: "preempt_locks" [fs/ntfs/ntfs.ko] undefined!
> *** Warning: "preempt_locks" [fs/nfs/nfs.ko] undefined!
> *** Warning: "preempt_locks" [fs/minix/minix.ko] undefined!
> *** Warning: "preempt_locks" [fs/jbd/jbd.ko] undefined!
> *** Warning: "preempt_locks" [fs/ext3/ext3.ko] undefined!
> *** Warning: "preempt_locks" [fs/cifs/cifs.ko] undefined!
> *** Warning: "preempt_locks" [fs/affs/affs.ko] undefined!
> *** Warning: "preempt_locks" [drivers/scsi/libata.ko] undefined!
> *** Warning: "preempt_locks" [drivers/scsi/ide-scsi.ko] undefined!
> *** Warning: "preempt_locks" [drivers/scsi/gdth.ko] undefined!
> *** Warning: "preempt_locks" [drivers/md/raid6.ko] undefined!
> *** Warning: "preempt_locks" [drivers/md/raid5.ko] undefined!
> *** Warning: "preempt_locks" [drivers/ide/ide-floppy.ko] undefined!
> *** Warning: "preempt_locks" [drivers/block/pktcdvd.ko] undefined!
> *** Warning: "preempt_locks" [drivers/block/loop.ko] undefined!

preempt_locks is being accessed from a module but is not exported.  This 
is turned on with CONFIG_DEBUG_RT_LOCKING_MODE so change that and it 
should build.

> #
> 
~
> -# CONFIG_EARLY_PRINTK is not set
> -# CONFIG_DEBUG_STACKOVERFLOW is not set
> +CONFIG_LATENCY_TRACE=y
> +CONFIG_RT_DEADLOCK_DETECT=y
> +CONFIG_DEBUG_RT_LOCKING_MODE=y <--------------------- This one is doing it............
> +CONFIG_DEBUG_KOBJECT=y
> +CONFIG_DEBUG_HIGHMEM=y
~
> +CONFIG_KGDB=y
> +CONFIG_KGDB_9600BAUD=y
> +# CONFIG_KGDB_19200BAUD is not set
> +# CONFIG_KGDB_38400BAUD is not set
> +# CONFIG_KGDB_57600BAUD is not set
> +# CONFIG_KGDB_115200BAUD is not set
> +CONFIG_KGDB_PORT=0x3f8
> +CONFIG_KGDB_IRQ=4
> +CONFIG_KGDB_MORE=y
> +CONFIG_KGDB_OPTIONS="-O1"
> +CONFIG_NO_KGDB_CPUS=8

The following are not in the latest kgdb...............
> +CONFIG_KGDB_TS=y
> +# CONFIG_KGDB_TS_64 is not set
> +CONFIG_KGDB_TS_128=y
> +# CONFIG_KGDB_TS_256 is not set
> +# CONFIG_KGDB_TS_512 is not set
> +# CONFIG_KGDB_TS_1024 is not set
.....................................
> +CONFIG_STACK_OVERFLOW_TEST=y
> +CONFIG_TRAP_BAD_SYSCALL_EXITS=y  <--- I recommend against this one, see notes at front of kgdb patch
> +CONFIG_KGDB_CONSOLE=y            <--- Likewise use this only if you have only one serial port and no VGA
> +CONFIG_KGDB_SYSRQ=y
> 
>  #
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
