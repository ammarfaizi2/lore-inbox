Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRBXR0F>; Sat, 24 Feb 2001 12:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129333AbRBXRZ4>; Sat, 24 Feb 2001 12:25:56 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:57869 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S129292AbRBXRZn>;
	Sat, 24 Feb 2001 12:25:43 -0500
Message-Id: <200102241725.KAA19514@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
cc: Philipp Rumpf <prumpf@mandrakesoft.com>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: Your message of Sat, 24 Feb 2001 09:54:47 CST.
In-Reply-To: <200102240941.CAA09708@ibg.colorado.edu> <Pine.LNX.4.10.10102240532030.30331-100000@penguin.transmeta.com> <20010224095447.A28983@mandrakesoft.mandrakesoft.com> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Sat, 24 Feb 2001 10:25:42 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your message of: Sat, 24 Feb 2001 09:54:47 CST, you write:
>Jeff, are you using the e820 memory map at all ?  In particular, are you
>using grub or some other buggy bootloader that insists on specifying a
>mem= option on the kernel command line ?  There should be a kernel command
>line message very early on, what does that say ?

Yes, I am using grub, the buggy bootloader.  The relevant chunk of
kernal messages are:

 BIOS-provided physical RAM map:
  BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
  BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
  BIOS-e820: 0000000000019800 @ 00000000000e6800 (reserved)
  BIOS-e820: 0000000013ef0000 @ 0000000000100000 (usable)
  BIOS-e820: 000000000000fc00 @ 0000000013ff0000 (ACPI data)
  BIOS-e820: 0000000000000400 @ 0000000013fffc00 (ACPI NVS)
  BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
 On node 0 totalpages: 81904
 zone(0): 4096 pages.
 zone(1): 77808 pages.
 zone(2): 0 pages.
 Kernel command line: root=/dev/hda1 mem=327616K

You are dead on, mem= seems a bit small.  Forcing mem=320M on the
command line fixes the problem completely.

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000019800 @ 00000000000e6800 (reserved)
 BIOS-e820: 0000000013ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000fc00 @ 0000000013ff0000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000013fffc00 (ACPI NVS)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
On node 0 totalpages: 81920
zone(0): 4096 pages.
zone(1): 77824 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 mem=320M
