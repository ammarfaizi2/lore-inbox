Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTEYRdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTEYRdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:33:44 -0400
Received: from www.wwns.com ([209.149.59.66]:47584 "EHLO wwns.wwns.com")
	by vger.kernel.org with ESMTP id S263671AbTEYRdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:33:43 -0400
From: "David R. Wilson" <david@wwns.com>
Message-Id: <200305251752.h4PHqw206618@wwns.wwns.com>
Subject: Re: Asrock K7S8X Motherboard kernel problem
To: mikpe@csd.uu.se
Date: Sun, 25 May 2003 12:52:58 -0500 (CDT)
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <200305241012.h4OACiZj011434@harpo.it.uu.se> from "mikpe@csd.uu.se" at May 24, 2003 12:12:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mikael and Vojtech,

I tried both bootloaders (LILO and Grub) and still can't seem to get the 
floppy controller detected with 2.4.21-rc3.

I tried the latest stock RedHat kernel (2.4.20-13.9) and it seems to work.
It sounds like Alan might have fixed something and hasn't told us what it 
was yet :-).  The RedHat kernel says:

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

With 2.4.21-rc3 I get:
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found

One other interesting bit that shows up in the RedHat dmesg is:

SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
advanced SiS pirq mapping not yet implemented

The motherboard has the SiS746 chipset along with the 963 southbridge.
I apparently copied an old dump (by hand) of the problem.  The patch
by Vojtech Pavlik for the SIS southbridge detects the 963 without
a problem.  I also added the Bios Enhanced Disk Device Service 3.0 patch 
(CONFIG_EDD) to the source.

http://domsch.com/linux/edd30/

I still get "no floppy controllers found" 

I am open to suggestions....

Thanks,
Dave


mikpe@csd.uu.se wrote...
> 
> On Fri, 23 May 2003 17:19:31 -0500 (CDT), David R. Wilson wrote:
> >I must be missing something, I have an Asrock K7S8X motherboard.
> ...
> >The boot messages mention a missing floppy controller among other 
> >problems:
> 
> Key words: Asrock (ASUS actually) and no FDC found.
> 
> This has been observed before on semi-recent ASUS mainboards.
> It's caused by some boot loaders that use an incorrect "out"
> instruction intended to reset the FDC. That "out" instruction
> was acceptable for ancient FDCs, but it locks up the FDCs in
> newer super-I/O chips found in some ASUS mainboards. The correct
> approach is to issue a BIOS call instead, or use a real driver
> that knows how to identify and drive newer FDCs.
> 
> This bug existed in the kernel's boot loader up until 2.4.13 or
> so when I fixed it to eliminate the FDC lock up problem on my
> ASUS P4T-E. Lilo and syslinux-2.02 don't have the bug. 


-- 
David R. Wilson  WB4LHO
World Wide Network Services
Nashville, Tennessee USA	Need QSL cards?
david@wwns.com			http://store.wwns.com/lz1jz


