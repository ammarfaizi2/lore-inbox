Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAKAKJ>; Wed, 10 Jan 2001 19:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAKAJ7>; Wed, 10 Jan 2001 19:09:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40465 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129511AbRAKAJq>; Wed, 10 Jan 2001 19:09:46 -0500
Message-ID: <3A5CF9C2.CE5EFF42@transmeta.com>
Date: Wed, 10 Jan 2001 16:09:38 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Dunlap, Randy" <randy.dunlap@intel.com>
CC: "'H. Peter Anvin'" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: The latest instance in the A20 farce
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEF6@orsmsx31.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dunlap, Randy" wrote:
> 
> a. The BIOS isn't required to have int. 0x15, AH=0x2401 [Appx. A],
>    but that is handled by your patch.

Idiots.  This should be required and be a null function; likewise
AH=0x2400.  The only thing that the current spec means is that 

> b. The BIOS isn't required to have int. 0x15, AH=0x88 [Appx. A]
>    (Ye Olde Traditional memory-size function).

Incorrect; see page 226.

>    Hopefully the other memory-size methods will always have
>    priority.
> c. A20M# is always de-asserted at the processor [Ch. 3, item SYS-0047]
> 
> I bring these up because they may have some impact on SYSLINUX,
> LILO, etc., and the data structures that they use (like the
> memory_size item) and because some of these systems don't
> have a "real mode," so loaders can't reliably assume that
> they do (unless it's transparent to the loaders)...
> and because you know something about SYSLINUX etc.
> 

URRRK.  I get a feeling these specs are either there to make life extra
difficult for programmers, because the people that design them are too
stupid to tie their own shoes, or because they want nothing but M$
factory-installed to work.  

A20M# always deasserted: this is all fine and good if we had nothing else
to worry about, but they really have managed to fuck up when it comes to
getting something to work *ACROSS THE BOARD*.  THEY DON'T GIVE ME A WAY
TO DETECT THE FACT THAT A20M# IS FIXED!!!!!  This is particularly nasty
when going back to real mode, since I don't have a way to figure out that
I can't turn A20M# back to its old state.  

I also really, really, *REALLY* hate them for killing serial ports.  It's
a Bad Idea[TM].

Worse, they define that port 92h, bit 1, is no longer A20M#... but they
don't forbid the system from using it for other things.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
