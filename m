Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSE3Vbc>; Thu, 30 May 2002 17:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316891AbSE3Vbc>; Thu, 30 May 2002 17:31:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316887AbSE3Vbb>;
	Thu, 30 May 2002 17:31:31 -0400
Message-ID: <3CF699E7.1E1FE0E1@zip.com.au>
Date: Thu, 30 May 2002 14:30:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Angelo Archie Amoruso <aamoruso@libero.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x.c Linux driver patch
In-Reply-To: <20020530230306.7a2caa09.aamoruso@libero.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Angelo Archie Amoruso wrote:
> 
> ...
>         { 0x10B7, 0x9050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905_1 },
>         { 0x10B7, 0x9051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905_2 },
>         { 0x10B7, 0x9055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_1 },
> +        { 0x00B7, 0x9055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_1 },
> 

erm..  0x10B7 is 3Com.  I suspect you've dropped a bit in the
device's EEPROM and it's loading the wrong manufacturer ID
into the PCI config registers.

Grab vortex-diag from http://www.scyld.com/diag/index.html and
run `vortex-diag -aaee'.  Look at the EEPROM section.  I get:

EEPROM contents (64 words, offset 0x30):
 0x000: 2978 6056 0040 8060 0040 0000 0000 0080
 0x008: 0000 0000 0000 0000 0000 0000 0000 0000
 0x010: 0000 0000 0000 0000 0000 0000 10b7 6356
 0x018: 0000 0000 0000 0000 0000 0000 0000 0a0a
 0x020: ff29 2829 0008 0000 0000 0000 0000 0000
 0x028: 0000 ff01 0000 0000 0000 0000 0000 0000
 0x030: 0000 8642 002e 6056 0061 0009 0000 6d50
 0x038: 2970 0009 0000 8642 002e 0010 0000 00aa

See the 10b7 at offset 0x016?  That's the manufacturer ID.

You _might_ be able to fix it with 3com's DOS-based setup
tool ftp://ftp.3com.com/pub/nic/3c90x/3c90xx2.exe or you
can just run with your patch and be happy ;)

-
