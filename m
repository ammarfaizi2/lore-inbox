Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTDVNoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTDVNoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:44:00 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:8968 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S263170AbTDVNn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:43:57 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D1B9@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Geert Uytterhoeven'" <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: RE: [PATCH] M68k IDE updates
Date: Tue, 22 Apr 2003 07:55:59 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
> Geert Uytterhoeven wrote:
>
> However, there's also a routine that involves more magic:
> taskfile_lib_get_identify(). While trying to understand that one, I found
more
> commands that should call the (possible byteswapping) hwif->ata_input_id()
> operations, like SMART commands. So first we need a clearer
differentiation
> between commands that transfer on-platter data, or other drive data.
> 
> Any comments from the IDE experts?
> 
> Gr{oetje,eeting}s,
> 
>						Geert


I'm hardly an expert, but all the specs can be found at http://www.t13.org

"typical" commands that involve platter data as of ATA-7 are:

COMMAND NAME			hex	decimal
===========================	===	=======

standard:

READ SECTOR(S)			20	32
READ SECTOR(S) w/ retry		21	33
WRITE SECTOR(S)			30	48
WRITE SECTOR(S) w/ retry	31	49
WRITE VERIFY			3c	60
READ MULTIPLE			c4	196
WRITE MULTIPLE			c5	197
READ DMA				c8	200
READ DMA w/ retry			c9	201
WRITE DMA				ca	202
WRITE DMA w/ retry		cb	203

48-bit feature set:

READ SECTOR(S) EXT		24	36
READ DMA EXT			25	37
READ MULTIPLE EXT			29	41
WRITE SECTOR(S) EXT		34	52
WRITE DMA EXT			35	53
WRITE MULTIPLE EXT		39	57

queued feature set:

READ DMA QUEUED EXT		26	38
WRITE DMA QUEUED EXT		36	54
SERVICE				a2	162
READ DMA QUEUED			c7	199
WRITE DMA QUEUED			cc	204

ata-7 fua feature set:

WRITE DMA FUA EXT			3d	61
WRITE DMA QUEUED FUA EXT	3e	62
WRITE MULTIPLE FUA EXT		ce	206

stream feature set:

READ STREAM DMA			2a	42
READ STREAM				2b	43
WRITE STREAM DMA			3a	58
WRITE STREAM			3b	59


Additionally I think the WRITE BUFFER / READ BUFFER pair are supposed to
work in the same format as a single sector write, however, they never go to
the media. (And of course byte-swapping doesn't matter, since if you issue a
read buffer, you must have immediately prior issued a write buffer command)

--eric
