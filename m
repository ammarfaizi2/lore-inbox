Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbTAMQjT>; Mon, 13 Jan 2003 11:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267882AbTAMQjS>; Mon, 13 Jan 2003 11:39:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22917 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267879AbTAMQjR>; Mon, 13 Jan 2003 11:39:17 -0500
Date: Mon, 13 Jan 2003 11:50:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mad Hatter <slokus@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bootsect.S: 2 questions
In-Reply-To: <20030113162827.46498.qmail@web13709.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1030113114007.21633A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Mad Hatter wrote:

> Hi,
> 
> I was looking through the linux (2.5.56) arch/i386/boot/bootsect.S and was
> puzzled about a couple of things:
> 
> 1. Near line 221 we have:
>        sread:  .word 0             # sectors read of current track
>        head:   .word 0             # current head
>        track:  .word 0             # current track
> 
>    However, since a diskette can have at most 2 heads, 80 tracks and 36 sectors
>    per track, why are these not bytes instead of words especially since space is
>    at such a tight premium in this code ?
>

Because, when they are used, they are ORed into word-sized registers.
The track and sector are are put into register CX and the head and drive
number are put into DX.

> 2. Near line 272 we have "movw    $7, %bx" but the documentation I've
>     been able to find about the "int 0x10" BIOS call says that for service
>     code 0xe (write character and advance cursor), it does not take an
>     attribute byte input parameter but rather uses the existing attribute. Is
>     this movw instruction superfluous ?
> 

On page 218, "System BIOS for IBM PC/XT/AT Computers", Phoenix
Technical Reference Series, ISBN 0-201-51806-6, the documentation
clearly states that BL contains the foreground color and BH the
active page. Therefore 0x0007 is the correct value to be put
into that register for the "Write Teletype to Active Page" function.

FYI, the startup functions are used once-per-boot. Any "improvements"
other than those necessary to "fix" something are useless in the
overall scheme of things.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


