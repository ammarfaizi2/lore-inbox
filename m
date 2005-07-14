Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVGNSuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVGNSuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVGNSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:50:00 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:51762 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263087AbVGNSt2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:49:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m5B35WDKUyGl9QxhKINJQjXs2E8owCxVTyOGOE16Km6cfUzmMKXOnWXGIKXQ7mRuH6w7OpC1fIbHL2onv6SP1/NzEhQTN8EdRJMpMVz+XyHL77vlCTYoWeq65+fu5y45ZVXLjUuYBcXy7i2myBQ6zS4NciyBbH1kujJvIK/X0EU=
Message-ID: <2ea3fae10507141148203bd32c@mail.gmail.com>
Date: Thu, 14 Jul 2005 11:48:47 -0700
From: yhlu <yinghailu@gmail.com>
Reply-To: yhlu <yinghailu@gmail.com>
To: Li-Ta Lo <ollie@lanl.gov>
Subject: Re: [LinuxBIOS] NUMA support for dual core Opteron
Cc: "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       LinuxBIOS <linuxbios@openbios.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1121365786.3317.6.camel@logarithm.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2ea3fae10507141058c476927@mail.gmail.com>
	 <1121365786.3317.6.camel@logarithm.lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For S2895, with 1Gx8 Installed and E stepping dual core opteron with
1G mem hole emable, got

Bootdata ok (command line is apic=debug ramdisk_size=65536
root=/dev/ram0 rw console=tty0 console=ttyS0,115200n8 )
Linux version 2.6.12-rc5 (root@tst288xsuse9) (gcc version 3.3.3 (SuSE
Linux)) #26 SMP Thu Jun 2 18:15:44 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000000dd0 (reserved)
 BIOS-e820: 0000000000000dd0 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 0000000100000000 - 0000000240000000 (usable)
ACPI: Unable to locate RSDP
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Node 0 MemBase 0000000000000000 Limit 000000013fffffff
Node 1 MemBase 0000000140000000 Limit 000000023fffffff
node 1 shift 24 addr 140000000 conflict 0
node 1 shift 25 addr 1fe000000 conflict 0
Using node hash shift of 26
Bootmem setup node 0 0000000000000000-000000013fffffff
Bootmem setup node 1 0000000140000000-000000023fffffff


~ # cat /proc/mt~ # cat /proc/mtrr 
reg00: base=0x00000000 (   0MB), size=8192MB: write-back, count=1
reg01: base=0x200000000 (8192MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size=1024MB: uncachable, count=1

with suse kernel and LinuxBIOS + S2882 I can get

linux:~ # cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  8131170304 145051648 7986118656        0 15220736 66543616
Swap: 2154979328        0 2154979328
MemTotal:      7940596 kB
MemFree:       7798944 kB
MemShared:           0 kB
Buffers:         14864 kB
Cached:          64984 kB
SwapCached:          0 kB
Active:          39056 kB
Inactive:        40844 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7940596 kB
LowFree:       7798944 kB
SwapTotal:     2104472 kB
SwapFree:      2104472 kB
BigFree:             0 kB

Node 0 MemTotal:      4194300 kB
Node 0 MemFree:      3793788 kB
Node 0 MemUsed:       400512 kB
Node 0 HighTotal:           0 kB
Node 0 HighFree:            0 kB
Node 0 LowTotal:      4194300 kB
Node 0 LowFree:       3793788 kB

Node 1 MemTotal:      4194300 kB
Node 1 MemFree:      4005156 kB
Node 1 MemUsed:       189144 kB
Node 1 HighTotal:           0 kB
Node 1 HighFree:            0 kB
Node 1 LowTotal:      4194300 kB
Node 1 LowFree:       4005156 kB

I wonder if suse kernel have some special code to show that. in
Kernel.org, I can not Node0....Node 1...

YH

On 7/14/05, Li-Ta Lo <ollie@lanl.gov> wrote:
> On Thu, 2005-07-14 at 10:58 -0700, yhlu wrote:
> > Someone mentioned that NUMA support for dual core opteron need acpi
> > support in LinuxBIOS.
> >
> > there may be some other solution for that.
> > 1. PowerPC already support dual core and it should support NUMA, So
> > the Open Firmware must have some NUMA entry definition.
> > Can we make x86-64 kernel support OpenFirmware interface so we can use
> > OpenBIOS as payload of LinuxBIOS.
> > 2. enable acpi and add the NUMA entries into it, the Linux Kernel will be happy.
> > 3. If we are trying to use ADLO to load Windows/Solaris/FreeBSD, We
> > need to pass related acpi info to ADLO....
> >
> > Solution 1 will be ideal one, and can make Solaris for X86-64 use
> > OpenFirmware interface too.....
> >
> > which one is better?
> >
> 
> 
> AFIAK, for x86_64 kernel, it will try to read NUMA configuration from
> HW directory. We don't have to export any ACPI table.
> 
> --
> Li-Ta Lo <ollie@lanl.gov>
> Los Alamos National Lab
> 
>
