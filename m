Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUJHU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUJHU6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJHU6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:58:41 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:63899 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264997AbUJHU6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:58:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: swsusp: 8-order memory allocations problem (was: Re: Fix random crashes in x86-64 swsusp)
Date: Fri, 8 Oct 2004 22:59:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
       agruen@suse.de
References: <200410052314.25253.rjw@sisk.pl> <200410062346.29489.rjw@sisk.pl> <20041006220600.GB25059@elf.ucw.cz>
In-Reply-To: <20041006220600.GB25059@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410082259.43627.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 07 of October 2004 00:06, Pavel Machek wrote:
> Hi!
> 
> fix_processor_context was calling functions marked __init on x86-64;
> bad idea. Maybe we should memset freed memory to zero so such bugs are
> prevented?
> 
> Thanks to Rafael for keeping notifying me about this bug, and someone
> get me yet another brown paper bag.
> 
> Anyway, this should fix it, please apply,
[-- snip --]

The patch apparently fixes the problem that I have reported, so thanks a lot, 
Pavel.  After it's been fixed, however, I often get things like that:

PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 
0x58b]...........................................................................
............................................swsusp: Need to copy 31927 pages
suspend: (pages needed: 31927 + 512 free: 98952)
hibernate.sh: page allocation failure. order:8, mode:0x120
Oct  8 14:15:57 albercik kernel:
Call Trace:<ffffffff8016eb2d>{__alloc_pages+749} 
<ffffffff8016ebd1>{__get_free_pages+33}
       <ffffffff80161a23>{suspend_prepare_image+531} 
<ffffffff8026d7a7>{pci_device_suspend+71}
       <ffffffff80161cb6>{swsusp_swap_check+22} 
<ffffffff802ea112>{suspend_device+50}
       <ffffffff80120d0c>{swsusp_arch_suspend+124} 
<ffffffff801610cc>{swsusp_suspend+12}
       <ffffffff8016222a>{pm_suspend_disk+90} 
<ffffffff8015fe04>{enter_state+68}
       <ffffffff802adc0d>{acpi_system_write_sleep+100} 
<ffffffff80193914>{vfs_write+228}
       <ffffffff80193a53>{sys_write+83} <ffffffff80110c72>{system_call+126}
Oct  8 14:16:05 albercik kernel:
suspend: Allocating pagedir failed.

It's sort of strange, because there were 250 meg of RAM available, out of 500, 
at that time.

Anyway I was able to suspend the machine after the above one had happened (I 
stopped an app occupying some memory and then the box suspended), but then I 
got a spectacular crash on resume (unfortunately I was unable to save the 
trace, but I'll try to reproduce it).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
