Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTANObG>; Tue, 14 Jan 2003 09:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbTANObG>; Tue, 14 Jan 2003 09:31:06 -0500
Received: from ns.tasking.nl ([195.193.207.2]:44036 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S262821AbTANObF>;
	Tue, 14 Jan 2003 09:31:05 -0500
Date: Tue, 14 Jan 2003 15:38:54 +0100
From: Dick Streefland <dick.streefland@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 - 2.4.20 : Boot parameter MEM= doesn't work anymore
Message-ID: <20030114143854.GA4289@altium.nl>
References: <20030114133944.GB8978@efrei.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114133944.GB8978@efrei.fr>
User-Agent: Mutt/1.3.27i
Organization: Altium BV, Amersfoort, The Netherlands
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 2003-01-14 14:39, Guillaume Allard wrote:
| Hi
| It seems that the boot parameter MEM= doesn't work anymore with the
| kernel 2.4.19 and 2.4.20.
| This parameter allows to force the amount of RAM for old computer that
| linux kernel doesn't found.
| 
| I am using a debian woody with lilo 22.2.
| The computer is an old compaq with a pentium 150MHz and 64Mb of memory.
| The kernel only see 16Mb of memory.
| 
| Here you can find the kernel boot messages, we can see that the kernel
| receve the parameters (Kernel command line: auto BOOT_IMAGE=Linux ro
| root=802 mem=64M) but that it doesn't work (Memory: 13608k/16384k
| available (1327k kernel code, 2388k reserved, 410k data, 256k init, 0k
| highmem).

For some reason, the interpretation of the mem= kernel parameter was
changed. I ran into this myself. The value is now used to limit the
memory size, not overrule it. There is a different syntax for adding
memory. One of my computers has 128 Mb, of which only 64 Mb are
detected. I had to add the "mem=63m@65m" kernel parameter, resulting in:

BIOS-provided physical RAM map:
BIOS-88: 0000000000000000 - 000000000009f000 (usable)
BIOS-88: 0000000000100000 - 00000000040ffc00 (usable)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.

Unfortunately, this is not documented. Look at arch/i386/kernel/setup.c
for details.

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------
