Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267827AbTAMQy5>; Mon, 13 Jan 2003 11:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267846AbTAMQy5>; Mon, 13 Jan 2003 11:54:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267827AbTAMQy4>;
	Mon, 13 Jan 2003 11:54:56 -0500
Date: Mon, 13 Jan 2003 08:59:41 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Mad Hatter <slokus@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bootsect.S: 2 questions
In-Reply-To: <20030113162827.46498.qmail@web13709.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L2.0301130844050.1675-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

(mostly "what R. Johnson said")

On Mon, 13 Jan 2003, Mad Hatter wrote:

| I was looking through the linux (2.5.56) arch/i386/boot/bootsect.S and was
| puzzled about a couple of things:
|
| 1. Near line 221 we have:
|        sread:  .word 0             # sectors read of current track
|        head:   .word 0             # current head
|        track:  .word 0             # current track
|
|    However, since a diskette can have at most 2 heads, 80 tracks and 36 sectors
|    per track, why are these not bytes instead of words especially since space is
|    at such a tight premium in this code ?

If you change those to bytes to save 3 bytes of space, and then you
change all of the instructions that load or store those values to 16-bit
registers, do you have a net saving of space?
Or you load/store them to 8-bit registers and rewrite the code, what
happens?

| 2. Near line 272 we have "movw    $7, %bx" but the documentation I've
|     been able to find about the "int 0x10" BIOS call says that for service
|     code 0xe (write character and advance cursor), it does not take an
|     attribute byte input parameter but rather uses the existing attribute. Is
|     this movw instruction superfluous ?

Perhaps, or perhaps on some particular system it was found to be needed.
We don't have a fully indexed changelog history of each line AFAIK.
Ralf Brown's interrupt page for this function says:
  BH = page number
  BL = foreground color (graphics modes only)
(see http://www.ctyme.com/intr/rb-0106.htm)
Or it could be important to clear BH and setting BL to 7 was just safe.

-- 
~Randy


