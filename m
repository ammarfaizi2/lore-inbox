Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSEJDLF>; Thu, 9 May 2002 23:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315764AbSEJDLE>; Thu, 9 May 2002 23:11:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9734 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315762AbSEJDLD>;
	Thu, 9 May 2002 23:11:03 -0400
Message-ID: <3CDB3AFA.31A377F@zip.com.au>
Date: Thu, 09 May 2002 20:14:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Silvan <silvan@windows-sucks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.18 + ext3 = filesystem corruption
In-Reply-To: <200205092156.12911.silvan@windows-sucks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting domain name.

Silvan wrote:
> 
> ...
>  I had a filesystem explosion (across the board corruption on all ext3
>  partitions, brought to my attention by a rather nasty series of EXT3_fs
>  errors and an immediate crash) about a month back.
> ...

I've just re-reviewed the 2.4.16 -> 2.4.18 diffs.  There's really
nothing there which could explain this.  We have:

- lots of s/bread/sb_bread/etc.  Which is rather unfortunate because
  it complicates any attempt to back out to 2.4.16's ext3.

- A bug fix for locking journal buffers (the infamous "request_list
  destroyed" bug)

- Some error-path-only code which remounts the fs readonly rather than taking
  down the machine when the unexpected happens.

> 
>  My hardware:
> 
>  AMD K7-1000 on ASUS A7V (VIA Apollo KT133a chipset, integrated Promise
>  ATA-100 controller), 256 MB RAM, Linksys 10/100E NIC, USR PCI Performance
>  Pro modem, SB PCI 128, Riva TNT2 AGP video (running at 4X in BIOS and in X),
>  CREATIVE CD-RW RW8439E, CD-950E/TKU, Maxtor 94610H6, generic PS/2 mouse,
>  generic FD, and a 104-key keyboard.

I'd be suspecting this, frankly.   Might be an IDE failure.

-
