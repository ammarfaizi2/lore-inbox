Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131097AbRAKBno>; Wed, 10 Jan 2001 20:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131192AbRAKBne>; Wed, 10 Jan 2001 20:43:34 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:22800 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131097AbRAKBnY>; Wed, 10 Jan 2001 20:43:24 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEF8@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'H. Peter Anvin'" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: The latest instance in the A20 farce
Date: Wed, 10 Jan 2001 17:43:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: H. Peter Anvin [mailto:hpa@transmeta.com]
> Sent: Wednesday, January 10, 2001 4:10 PM
> 
> "Dunlap, Randy" wrote:
> > 
> > a. The BIOS isn't required to have int. 0x15, AH=0x2401 [Appx. A],
> >    but that is handled by your patch.
> 
> Idiots.  This should be required and be a null function; likewise
> AH=0x2400.  The only thing that the current spec means is that 
> 
> > b. The BIOS isn't required to have int. 0x15, AH=0x88 [Appx. A]
> >    (Ye Olde Traditional memory-size function).
> 
> Incorrect; see page 226.

Right.  Somehow I looked at that and didn't see it.

> >    Hopefully the other memory-size methods will always have
> >    priority.
> > c. A20M# is always de-asserted at the processor [Ch. 3, 
> item SYS-0047]
> > 
> > I bring these up because they may have some impact on SYSLINUX,
> > LILO, etc., and the data structures that they use (like the
> > memory_size item) and because some of these systems don't
> > have a "real mode," so loaders can't reliably assume that
> > they do (unless it's transparent to the loaders)...
> > and because you know something about SYSLINUX etc.
> > 
> 
> URRRK.  I get a feeling these specs are either there to make 
> life extra difficult for programmers,
> because the people that design them are too
> stupid to tie their own shoes, or because they want nothing but M$
> factory-installed to work.
> 
> A20M# always deasserted: this is all fine and good if we had 
> nothing else
> to worry about, but they really have managed to fuck up when 
> it comes to
> getting something to work *ACROSS THE BOARD*.  THEY DON'T 
> GIVE ME A WAY
> TO DETECT THE FACT THAT A20M# IS FIXED!!!!!  This is 
> particularly nasty
> when going back to real mode, since I don't have a way to 
> figure out that I can't turn A20M# back to its old state.  

I'm not sure about this, but I'm wondering if the
Fixed (as in Static) ACPI Description Table (FADT)
can indicate that the platform is a legacy-free system.

According to the ACPI 2.0 spec, FADT field "Boot Architecture
Flags", bit 0 (LEGACY_DEVICES) indicates whether there are
legacy devices (user-visible) on the system.  I'm not sure
that this is adequate/equivalent.  I'll continue to check into it.
Even if it is adequate/equiv, it's not pretty.

> I also really, really, *REALLY* hate them for killing serial 
> ports.  It's a Bad Idea[TM].

Got the Message.

> Worse, they define that port 92h, bit 1, is no longer 
> A20M#... but they
> don't forbid the system from using it for other things.

I don't quite see it that way.  Where do you see that?
Maybe it just needs to be more explicit.

Ch. 3 (SYS-0047) says that port 92h:bit 1 doesn't toggle/affect A20M#.
Appendix A says that port 92h is (still?) "System Control Port A"
(not defined here AFAIK).
(I haven't checked all of the other chapters/appendices.)

> 	-hpa
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
