Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVDEUeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVDEUeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDEUcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:32:33 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:31898 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261964AbVDEUKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:10:01 -0400
Message-ID: <4252F090.4040605@mesatop.com>
Date: Tue, 05 Apr 2005 14:09:52 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Reuben Farrelly <reuben-lkml@reub.net>, len.brown@intel.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no> <42524D83.1080104@reub.net> <20050405121444.GB6885@stusta.de> <6.2.3.0.2.20050406002812.04393a30@tornado.reub.net> <20050405132417.GD6885@stusta.de>
In-Reply-To: <20050405132417.GD6885@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Apr 06, 2005 at 12:32:52AM +1200, Reuben Farrelly wrote:
> 
>>Hi again
>>
>>At 12:14 a.m. 6/04/2005, Adrian Bunk wrote:
>>
>>>On Tue, Apr 05, 2005 at 08:34:11PM +1200, Reuben Farrelly wrote:
>>>
>>>
>>>>Hi,
>>>
>>>Hi Reuben,
>>>
>>>
>>>>...
>>>>Hrm. Something changed between the last -mm release which compiled
>>>>through, and this one..
>>>>...
>>>>  LD      .tmp_vmlinux1
>>>>arch/i386/kernel/built-in.o(.init.text+0x1823): In function `setup_arch':
>>>>: undefined reference to `acpi_boot_table_init'
>>>>arch/i386/kernel/built-in.o(.init.text+0x1828): In function `setup_arch':
>>>>: undefined reference to `acpi_boot_init'
>>>>make: *** [.tmp_vmlinux1] Error 1
>>>>[root@tornado linux-2.6]#
>>>>
>>>>Backing out bk-acpi.patch works around it..
>>>
>>>Please send your .config .
>>
>>Have just figured out that it seems to be caused by having ACPI 
>>disabled in .config, once I re-enabled ACPI the build problem went away.
>>
>>Config attached anyway, I imagine the problem is quite reproduceable..
> 
> 
> Ah, this was the working .config .
> fter setting CONFIG_ACPI=n I started seeing different but most likely 
> related problems.
> 
> 
> @Len:
> ACPI=y and ACPI_BOOT=n seems to be a legal configuration (with 
> X86_HT=y), but it breaks into pieces if you try the compilation.
> 

Here is some additional and hopefully helpful information.
Without CONFIG_ACPI=y, I first got:

arch/i386/kernel/setup.c: In function 'setup_arch':
arch/i386/kernel/setup.c:1571: warning: implicit declaration of function 'acpi_boot_table_init'
arch/i386/kernel/setup.c:1572: warning: implicit declaration of function 'acpi_boot_init'

and then at the end:

arch/i386/kernel/built-in.o(.init.text+0x1b81): In function `setup_arch':
: undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x1b86): In function `setup_arch':
: undefined reference to `acpi_boot_init'
make: *** [.tmp_vmlinux1] Error 1

With these set linux-2.6.12-rc2-mm1 built OK.

[steven@spc1 linux-2.6.12-rc2-mm1]$ grep ^CONFIG_ACPI .config
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

Steven
