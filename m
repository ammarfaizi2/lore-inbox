Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282482AbSAEUHk>; Sat, 5 Jan 2002 15:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282508AbSAEUHa>; Sat, 5 Jan 2002 15:07:30 -0500
Received: from glisan.hevanet.com ([198.5.254.5]:3852 "EHLO glisan.hevanet.com")
	by vger.kernel.org with ESMTP id <S282482AbSAEUHS>;
	Sat, 5 Jan 2002 15:07:18 -0500
Date: Sat, 5 Jan 2002 12:06:56 -0800 (PST)
From: jkl@miacid.net
To: "Joseph S. Myers" <jsm28@cam.ac.uk>
cc: Florian Weimer <fw@deneb.enyo.de>, dewar@gnat.com,
        Dautrevaux@microprocess.com, paulus@samba.org,
        Franz.Sirl-kernel@lauterbach.com, benh@kernel.crashing.org,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <Pine.LNX.4.33.0201051929080.485-100000@kern.srcf.societies.cam.ac.uk>
Message-ID: <Pine.BSI.4.10.10201051150430.8542-100000@hevanet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jan 2002, Joseph S. Myers wrote:

> 
> On Sat, 5 Jan 2002 jkl@miacid.net wrote:
> 
> > Wat this last bit added to the standard after ANSI/ISO 9899-1990?  I'm
> > looking through my copy and I can't find it.  All I can find is that
> 
> I was quoting from the GCC manual (providing the documentation
> implementations are required to provide of implementation-defined
> behaviour); of course the subclause numbers are different in C99 (from
> which the subclause numbers in the GCC manual are given) from those in
> C90.  Perhaps once all the documentation for implementation-defined
> behaviour in C99 is present I'll go over what's required to document it
> all relative to C90 as well.
> 
> > 	I interpret this to mean that one MAY use integer arithmatic to
> > do move a pointer outside the bounds of an array.  Specifically, as soon
> > as I've cast the pointer to an integer, the compiler has an obligation to
> > forget any assumptions it makes about that pointer.  This is what casts
> > from pointer to integer are for!  when i say (int)p I'm saying that I
> > understand the address structure of the machine and I want to manipulate
> > the address directly.
> 
> Just because you've created a pointer P, and it compares bitwise equal to
> a valid pointer Q you can use to access an object, does not mean that P
> can be used to access that object.  Look at DR#260, discussing the
> provenance of pointer values, which arose from extensive discussion in the
> UK C Panel, and if you think it should be resolved otherwise from how we
> (UK C Panel) proposed then raise your position on it at a meeting of your
> National Body before the next WG14 meeting.
> 
> http://std.dkuug.dk/JTC1/SC22/WG14/www/docs/dr_260.htm
> 

I don't particularly like the interpretation stated in DR260, but that
doesn't matter.  It still doesn't give the compiler permission to make
something "undefined behavior" that the standard says is "implementation
defined".  The standard says an arbitrary integer (arbitrary means there
are no restrictions on how it was produced) can be converted to a pointer
and that the implementation must define what the results of this are.
  All DR260 is saying is that the compiler can do certain sorts of deep
analysis on the code to decide whether my pointer is valid.  It doesn't
apply to the case of casting to an integer, munging, then casting back
because the the implementation is supposed to provide a rule for when
such pointers are valid.

Of course the GCC folks are within their rights to say that the
implementation defined behavior is "all pointers created from integers are
broken" but this is THEIR DECISION not a consequence of the standard, and
not a consequence of DR260.  And it would be a very, very bad decision
given that one of the major uses of GCC is to build Linux, and
apparently Linux breaks when this happens.

Or to put it another way: The Linux kernel developers NEED an
implementation defined way to build a pointer from an address.  If
arithmatic on byte pointers isn't it (which is perfectly understandable)
and casting a pointer from an integer isn't it, then can someone please
tell us (not just "that will work for now" or "that will probably work")
how do we do that?

-JKL


