Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUBDQPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 11:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBDQPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 11:15:38 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:18586 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263475AbUBDQPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 11:15:24 -0500
Date: Wed, 04 Feb 2004 08:15:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Martin Hicks <mort@bork.org>, Uher Marek <Marek.Uher@t-mobile.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with NUMA kernel on IBM xSeries 455 server
Message-ID: <34760000.1075911317@[10.10.2.4]>
In-Reply-To: <20040204132157.GA3387@localhost>
References: <6D2F48AA9477864682B4078EFF1BEAF1057F0B7D@RDMKSPE02.rdm.cz> <20040204132157.GA3387@localhost>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Feb 04, 2004 at 01:46:33PM +0100, Uher Marek wrote:
>> 
>> 	Hi all,
>> 
>> I have a problem with running Linux on my IBM xSeries 455 server (4 x Intel 
>> Xeon MP CPU 2.80GHz, 8 GB RAM). I have tried to compile kernel 2.6.2 with
>> Summit/EXA (IBM x440) NUMA support, high memory support (64GB), NUMA memory
>> allocation support, ACPI and ACPI NUMA support. When I have tried to make
>> bzImage I have got this messages:
>> 
>> drivers/built-in.o(.init.text+0x1751): In function `acpi_parse_slit': 
>> : undefined reference to `acpi_numa_slit_init'
>> drivers/built-in.o(.init.text+0x176d): In function `acpi_parse_processor_affinit
>> y':
>> : undefined reference to `acpi_numa_processor_affinity_init'
>> drivers/built-in.o(.init.text+0x1791): In function `acpi_parse_memory_affinity':
>> : undefined reference to `acpi_numa_memory_affinity_init'
>> drivers/built-in.o(.init.text+0x1850): In function `acpi_numa_init':
>> : undefined reference to `acpi_numa_arch_fixup'
>> make: *** [.tmp_vmlinux1] Error 1
>> 
>> Do you have any idea? I don't know what is wrong.
> 
> According to include/linux/acpi.h these functions are platform
> dependent.  There are ia64 versions, but I don't see them for non-ia64
> arches.
> 
> This is the problem.  I don't know anything about Summit, so maybe
> someone else can better help you.  Perhaps there is an extra summit
> patch somewhere?  Or maybe you must turn off ACPI for this machine,
> although that seems unlikely.

I think you want to disable CONFIG_ACPI_NUMA, but leave on CONFIG_ACPI
and CONFIG_NUMA. Summit has it's own versions, which are automatically
linked in by turning on X440 support. 

Please let me know if that fixes it ... I'll remove the beartrap by 
disabling that config option for x86 if so.

M.

