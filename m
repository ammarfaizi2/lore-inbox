Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277968AbRJWQsr>; Tue, 23 Oct 2001 12:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277970AbRJWQsh>; Tue, 23 Oct 2001 12:48:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64518 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277968AbRJWQsR>; Tue, 23 Oct 2001 12:48:17 -0400
Subject: Re: 2.4.12-ac5: IDE-SCSI kernel panic
To: xavier.bestel@free.fr (Xavier Bestel)
Date: Tue, 23 Oct 2001 17:55:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1003852178.9892.51.camel@nomade> from "Xavier Bestel" at Oct 23, 2001 05:49:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w4pn-0006Wr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> scsi0: ERROR on channel 0, id 1, lun 0, CDB: Request Sense 00 00 00 40 00
> Info fld=0x437ea, Current sd0b:00: sense key Medium Error
> Additional sense indicates Unrecovered read error
>  I/O error: dev 0b:00, sector 1105832

This stuff is ok.

> Incorrect segment count at 0xc01e4342nr_segments is 3f
> counted segments is 19
> Flags 0 0
> Segment 0xd92e86c0, blocks 4, addr 0x1f983fff
> Segment 0xd92e8660, blocks 4, addr 0x1f9847ff
> [I'm not copying them all, around 25 of them]
> Kernel panic: Ththththaats all folks. Too dangerous to continue.

Someone did a partial I/O and then it seems failed to properly update
the descriptor when retrying half of it. Ugly. This looks like a CD trace
so I assume this was sr.c that barfed. It could also be a generic
scsilib bug 
