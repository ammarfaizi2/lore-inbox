Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWJAOLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWJAOLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWJAOLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 10:11:50 -0400
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:3778 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932183AbWJAOLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 10:11:49 -0400
Date: Sun, 1 Oct 2006 16:10:20 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>,
       <linux-kernel@vger.kernel.org>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
Message-ID: <20061001161020.20e941c6@localhost>
In-Reply-To: <Pine.LNX.4.44L0.0609301131190.7052-100000@netrider.rowland.org>
References: <20060930141455.29fdadef@localhost>
	<Pine.LNX.4.44L0.0609301131190.7052-100000@netrider.rowland.org>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 11:49:52 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> The alternative is that something caused a jump directly to the byte at 
> 2b.  Maybe a return address got corrupted on the stack; obviously there 
> aren't any direct jumps to that location.  I don't have a clue how to 
> track this any further.
> 
> We can rule out the possibility that the kernel's object code was
> corrupted.  The dump in the oops message agrees exactly with the objdump
> output.
> 
> The simplest answer is that Arkadiusz's CPU is a little flakey.  But 
> that would be too easy.


Another crazy theory (based on my horrible experience with a
defective memory module):

There is an hard to trigger single bit error not detected by memtest
near (physical) memory address 6b79f00(ESP) (where the EIP has been
retrived causing the Oops).

In this case the physical address (at Kb 110055) can be skipped with
"memmap=1K$110055K" kernel boot option.


Arkadiusz, can you try to add that option to kernel command line (in
lilo or grub config)? You can check if you've done it right with
	"dmesg | less"

At the begin there is the memory map provided by BIOS:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
[    0.000000]  BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)


Just after that there should be another memory map with an additional
line that marks the memory region [06B79C00 - 06B7A000] as reserved.

Then you can try again to make 2.6.18 crash.


And if the problem is still here I think that another kernel Oops text
can be useful: it can show if there is a common pattern (if you have a
digital camera you can take a screenshot of the screen avoiding the
hand-copy).

-- 
	Paolo Ornati
	Linux 2.6.18 on x86_64
