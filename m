Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUBHS6v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 13:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbUBHS6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 13:58:50 -0500
Received: from terminus.zytor.com ([63.209.29.3]:20203 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S264329AbUBHS6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 13:58:48 -0500
Message-ID: <402686E0.3040806@zytor.com>
Date: Sun, 08 Feb 2004 10:58:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andrea Mazzoleni <amadvance@users.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [syslinux] SYSLINUX 2.09-pre11
References: <402343F8.6020806@zytor.com> <20040208142021.GA494@elitel.biz>
In-Reply-To: <20040208142021.GA494@elitel.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Mazzoleni wrote:
> On 02/05, H. Peter Anvin wrote:
> 
>>Please test it out.  Some time over the weekend I'm going to do a sweep 
>>for bug fixes I've forgotten and otherwise I'd like to release 2.09 next 
>>week.
> 
> Please consider to compare the behaviour of the SYSLINUX mem= option with
> the Linux kernel behaviour. I've rechecked it a lot of time, and I'm sure that
> there is a difference.
> 
> In the kernel function parse_cmdline_early() in the file arch/i386/kernel/setup.c
> the "mem=" option is used to only reducing (and never expanding) the memory map
> calling the limit_regions() function. This happen also if E820 is not available.
> 
> Instead, SYSLINUX uses the "mem=" option also for expanding the memory map
> over the value read from the BIOS.
> 
> Please note that this is only true for the simplest format of the "mem=" option
> like "mem=512M". Other formats like "mem=512M@512M" have different behaviours
> because add_memory_region() is called instead of limit_regions().
> 
> Also note that if E820 is not present, a fake E820 memory map is created
> in the setup_memory_regions() kernel function in arch/i386/kernel/setup.c.
> This is the fake memory map on which the limit_regions() function operates.
> That exactly happen is that copy_e820_map() returns -1 because "nr_map" is
> set to 0 in the arch/i386/boot/setup.S file if E820 is not present.
> 

This is unfixable, because someone fucked up and re-used a 
well-established protocol-defined option for another purpose.  E.g. 
"mem=512M" has meant exactly that (and was/is widely used to specify 
that memory should be added up to 512M).

Since the behaviour you describe is kernel-version-dependent, IT CANNOT 
BE FIXED IN THE BOOTLOADER, and whomever thought it was a good idea to 
mess with mem= should be taken out and shot.

	-hpa
