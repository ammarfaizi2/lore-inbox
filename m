Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315143AbSDWOYx>; Tue, 23 Apr 2002 10:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315174AbSDWOYw>; Tue, 23 Apr 2002 10:24:52 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:25085 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315143AbSDWOYw>; Tue, 23 Apr 2002 10:24:52 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <UTC200204231404.g3NE41414336.aeb@smtp.cwi.nl> 
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        mdharm-usb@one-eyed-alien.net
Subject: Re: Flash device IDs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 15:24:46 +0100
Message-ID: <3782.1019571886@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries.Brouwer@cwi.nl said:
>  It is worse. The commands are SCSI-like, but vendor-unique. So one
> has to discover the commands and the details of the media format. I
> wrote an ECC routine, and do something more or less random for the
> connection between logical and physical blocks. If you have ECC and
> LBA/PBA handling, then there is more to merge.

>From a brief perusal of the code, it looks like the commands map to basic 
operations on NAND flash - read/write/erase commands?

> [Things are not quite straightforward. I think the media uses 512+16
> byte sectors, but my SCSI commands must use 512+64 byte sectors.][Of
> course 512 and 16 are variables. Don't know about 64.] 

That definitely sounds like you're dealing with raw NAND flash chips - 
512 bytes with 16 bytes of 'spare' area - albeit through a _very_ 
strange interface.

If we have to write code to handle the actual SmartMedia translation layer,
which does translation of logical addresses to physical addresses for reads
and handles safely writing the data to a new address before updating the
metadata and possibly erasing old versions of the replaced logical sector,
etc, then we should make sure it works with both the USB readers and the 
raw flash chips.


--
dwmw2


