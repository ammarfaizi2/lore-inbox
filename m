Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVEZHXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVEZHXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVEZHXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:23:50 -0400
Received: from dvhart.com ([64.146.134.43]:53667 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261238AbVEZHXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:23:47 -0400
Date: Thu, 26 May 2005 00:23:46 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       christoph@lameter.com
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <196240000.1117092225@[10.10.2.4]>
In-Reply-To: <195320000.1117091674@[10.10.2.4]>
References: <175590000.1117089446@[10.10.2.4]> <20050525234717.261beb48.akpm@osdl.org> <191140000.1117091133@[10.10.2.4]> <195320000.1117091674@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Thursday, May 26, 2005 00:14:34 -0700):

> 
> 
> --"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Thursday, May 26, 2005 00:05:33 -0700):
> 
>> 
>> 
>> --Andrew Morton <akpm@osdl.org> wrote (on Wednesday, May 25, 2005 23:47:17 -0700):
>> 
>>> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>>> 
>>>> Build failure on numaq:
>>>>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq
>>>> 
>>>>  In file included from include/linux/sched.h:12,
>>>>                   from arch/i386/kernel/asm-offsets.c:7:
>>>>  include/linux/jiffies.h:42:3: #error You lose.
>>> 
>>> You lost!  CONFIG_HZ didn't get set.
>>> 
>>> Something obviously went wrong in the magic in kernel/Kconfig.hz.  Wanna do
>>> `grep HZ .config' and see if you can work out why it broke?
>> 
>> Tis conspicious by it's absence.
>> 
>> mbligh@kernel:~/linux-2.6.12-rc5-mm1$ grep HZ .config
>> mbligh@kernel:~/linux-2.6.12-rc5-mm1$ 
>> 
>> I'll poke at it in the morning, with the benfits of less wine, and more 
>> sleep
>> 
>> M.
> 
> source kernel/Kconfig.hz is under:
> menu "APM (Advanced Power Management) BIOS Support"
> depends on PM && !X86_VISWS
> 
> So it's screwed if you don't have PM defined, it seems.

Ironically once I work around that it fails with:

arch/i386/kernel/built-in.o(.init.text+0xfe4): In function `sys_set_thread_area':
arch/i386/kernel/process.c:869: undefined reference to `acpi_read_root_resources'
drivers/built-in.o(.text+0x1fa3d): In function `acpi_pci_root_add':
drivers/acpi/pci_root.c:275: undefined reference to `pci_acpi_scan_root'
make: *** [.tmp_vmlinux1] Error 1

instead. Oh well. bedtime.

M.

