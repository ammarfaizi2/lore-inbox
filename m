Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268458AbTANBGp>; Mon, 13 Jan 2003 20:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268465AbTANBGp>; Mon, 13 Jan 2003 20:06:45 -0500
Received: from web13707.mail.yahoo.com ([216.136.175.140]:6824 "HELO
	web13707.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268458AbTANBGo>; Mon, 13 Jan 2003 20:06:44 -0500
Message-ID: <20030114011533.98422.qmail@web13707.mail.yahoo.com>
Date: Mon, 13 Jan 2003 17:15:33 -0800 (PST)
From: Mad Hatter <slokus@yahoo.com>
Subject: Re: bootsect.S: 2 questions
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0301130844050.1675-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointers to Ralf Brown's interrupt page.

--- "Richard B. Johnson" <root@chaos.analogic.com> wrote:

>FYI, the startup functions are used once-per-boot. Any "improvements"
>other than those necessary to "fix" something are useless in the
>overall scheme of things.

Sure. I'm a novice at both the x86 instruction set and the GNU assembler
and I'm just trying to understand the reason the code is written the way
it is.

--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
 
> If you change those to bytes to save 3 bytes of space, and then you
> change all of the instructions that load or store those values to 16-bit
> registers, do you have a net saving of space?
> Or you load/store them to 8-bit registers and rewrite the code, what
> happens?

I looked at one place where these words are used: the read_track routine.
Part of that code looks like this:
-------------------------------
	movw	4(%si), %dx		# 4(%si) = track
	movw	(%si), %cx		# (%si)  = sread
	incw	%cx
	movb	%dl, %ch
	movw	2(%si), %dx		# 2(%si) = head
	movb	%dl, %dh
	andw	$0x0100, %dx
	movb	$2, %ah
---------------------------------

If this code is rewritten to use byte instructions (and sread, head, track
are changed to .byte instead of .word) like so (the last two instructions
are unchanged):
-----------------------------------------------
	movb	(%si), %cl		# (%si)  = sread
	incb	%cl
	movb	2(%si), %ch		# 2(%si) = track
	movb	1(%si), %dh		# 1(%si) = head
	andw	$0x0100, %dx
	movb	$2, %ah
------------------------------------------------

there is a net saving of 6 bytes. (I compiled this with "gcc -c", linked
with "ld --oformat binary -Ttext 0x0" and compared the size of the results).

I'm not proposing this as a fix BTW; just an academic exercise, really.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
