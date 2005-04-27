Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVD0Qqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVD0Qqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVD0Qqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:46:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:42974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261783AbVD0Qqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:46:33 -0400
Date: Wed, 27 Apr 2005 09:46:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: vgoyal@in.ibm.com
Cc: akpm@osdl.org, sharyathi@in.ibm.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [Fastboot] Re: Kdump Testing
Message-Id: <20050427094628.2721606e.rddunlap@osdl.org>
In-Reply-To: <20050426085448.GB4234@in.ibm.com>
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
	<20050425160925.3a48adc5.rddunlap@osdl.org>
	<20050426085448.GB4234@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 14:24:48 +0530
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> > 
> > 2.6.12-rc2-mm3 reboots vmlinux-recover-UP on panic.
> > (vmlinux-recover-SMP hangs during [early] reboot, but -UP
> > goes further....)
> > 
> > (BTW, how does I do serial console from the second
> > kernel...?  It has the drivers, but not the command
> > line info?  TBD.)
> > 
> 
> 
> While pre-loading the capture kernel using kexec, you can specify the command
> line options to second kernel using --append="". You must already be passing
> the root device. Add you serial console parameters as well something like
> --append="console=ttyS0, 38400"

Yes, that's what I was planning to try anyway, thanks for the
confirmation.  Finally got it working.


> > vmlinux-recover-UP gets to this point, hand-written,
> > several lines missing:
> > 
> > kfree_debugcheck: bad ptr c3dbffb0h.  ( == %esi)
> > kernel BUG at <bad filename>:23128!
> > invalid operand: 0000 [#1]
> > DEBUG_PAGEALLOC
> > EIP is at kfree_debugcheck+0x45/0x50
> > 
> > Stack dump shows lots of ext3 cache and inode functions...
> > 
> 
> Can you post a full serial console output of second kernel? That would help.

Here:

 Linux version 2.6.12-rc2-mm3 (rddunlap@gargoyle) (gcc version 3.3.3 (SuSE Linux)) #25 Tue Apr 26 17:52:39 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 000000000144d000 (usable)
 user: 00000000014ed400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
DMI 2.3 present.
Allocating PCI resources starting at 05000000 (gap: 05000000:fb000000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda9 nosmp console=ttyS0,115200n8 console=tty0 init 1 memmap=exactmap memmap=640K@0K memmap=4404K@16384K memmap=60491K@21429K elfcorehdr=21428K
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 1685.910 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Unknown interrupt or fault at EIP 00000246 00000060 c13d6653   [*1]
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59468k/81920k available (2561k kernel code, 5956k reserved, 1311k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.

---
[1] c13d6653 is vfs_caches_init_early
