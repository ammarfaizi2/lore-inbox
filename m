Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276912AbRJCIRA>; Wed, 3 Oct 2001 04:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276911AbRJCIQt>; Wed, 3 Oct 2001 04:16:49 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:25223 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S276910AbRJCIQi>; Wed, 3 Oct 2001 04:16:38 -0400
Date: Wed, 3 Oct 2001 09:17:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now
Message-ID: <20011003091702.B1175@flint.arm.linux.org.uk>
In-Reply-To: <31135.1002083784@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <31135.1002083784@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Wed, Oct 03, 2001 at 02:36:24PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 02:36:24PM +1000, Keith Owens wrote:
> Either export the required symbols
> (remember to add the .o file to export-objs in the Makefile) or add
> EXPORT_NO_SYMBOLS; somewhere in the module (no change to Makefile).
> 
>  objdump -h `modprobe -l` | \
>  awk '/file format/{file = $1}/__ksymtab/{file = ""}/\.comment/ && file != "" {print file}'

Sorry, your awk script is buggy - it doesn't take note of __ksymtab
after .comment:

# objdump -h /lib/modules/2.4.9-ac17/kernel/drivers/acorn/scsi/acornscsi_mod.o

/lib/modules/2.4.9-ac17/kernel/drivers/acorn/scsi/acornscsi_mod.o:     file format elf32-littlearm

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         0000466c  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .rodata       00000de6  00000000  00000000  000046a0  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .modinfo      00000028  00000000  00000000  00005488  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .data         000000bc  00000000  00000000  000054b0  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  4 .bss          0000008c  00000000  00000000  0000556c  2**2
                  ALLOC
  5 .comment      00000026  00000000  00000000  0000556c  2**0
                  CONTENTS, READONLY
  6 __ksymtab     00000000  00000000  00000000  00005592  2**0
                  CONTENTS, READONLY


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

