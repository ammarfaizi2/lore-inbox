Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVH0AYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVH0AYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVH0AYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:24:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22514 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965175AbVH0AYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:24:38 -0400
Message-ID: <430FB2B9.2090107@mvista.com>
Date: Fri, 26 Aug 2005 17:24:25 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
CC: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: kgdb on EM64T
References: <194B303F2F7B534594F2AB2D87269D9F06EA2445@orsmsx408>
In-Reply-To: <194B303F2F7B534594F2AB2D87269D9F06EA2445@orsmsx408>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilkerson, Bryan P wrote:
> 
> George Anzinger [mailto:george@mvista.com] wrote:
> 
>>Well, I checked, it is "int $3".  Why then the panic?  If you try the
>>boot with kgdb (i.e. wait) and the do:
>>(gdb) disass gdb_interrupt
>>What do you find at +75?
> 
> 
> Below is the console from the session it is interesting that gdb is not
> able to access the memory.   I let it continue and then ctrl-c broke it
> later in the boot cycle and tried disass again with the same result.
> 
> Feel free to flog me if this is stupid but I have just one EM64T machine
> (test) and I'm using a regular P4 machine as dev.  I build the test
> kernel on the EM64T machine and then copy the updated sources, object
> files, and images via NFS to the dev machine.  I believe I read in the
> kgdb doc that it was possible to use to different architecture machines
> for test and dev although there wasn't any information about how to do
> it.  This is probably the source of the OS/ABI warning.  I can probably
> get the mothership to send me another EM64T machine if need be.  

What you need is a cross development environment.  Not having that, your 
gdb is likely not aware of how to talk to the hardware you are using. 
The cross develoment should cost a whole lot less than another machine.

George
-- 
> 
> vincent:/home/bwilkers/proj/linux-2.6.13-rc4-mm1 # gdb vmlinux
> GNU gdb 6.3
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you
> are
> welcome to change it and/or distribute copies of it under certain
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for
> details.
> This GDB was configured as "i586-suse-linux"...
> warning: A handler for the OS ABI "GNU/Linux" is not built into this
> configuration
> of GDB.  Attempting to continue with the default i386:x86-64 settings.
> 
> Using host libthread_db library "/lib/tls/libthread_db.so.1".
> 
> (gdb) target remote /dev/ttyS0
> Remote debugging using /dev/ttyS0
> 0x80503b50 in ?? ()
> warning: no shared library support for this OS / ABI
> (gdb) disass gdb_interrupt
> Dump of assembler code for function gdb_interrupt:
> 0xffffffff80247009 <gdb_interrupt+0>:   Cannot access memory at address
> 0x80247009
> (gdb) c
> Continuing.
> Bootdata ok (command line is root=/dev/sda2 kgdb console=kgdb)
> Linux version 2.6.13-rc4-mm1-perfmon-em64t (bwilkers@jules) (gcc version
> 3.3.5 20050117 (prerelease) (SUSE Linux)) #43 SMP Sat Aug 27 15:56:14
> MDT 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fe2f800 (usable)
>  BIOS-e820: 000000003fe2f800 - 000000003fe3f832 (ACPI NVS)
>  BIOS-e820: 000000003ff10000 - 000000003ff30000 (reserved)
>  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
>  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
>  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fed13000 - 00000000fed1a000 (reserved)
>  BIOS-e820: 00000000fed1c000 - 00000000feda0000 (reserved)
> ACPI: PM-Timer IO Port: 0x408
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> 
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
