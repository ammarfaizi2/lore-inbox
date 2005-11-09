Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVKIJXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVKIJXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 04:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVKIJXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 04:23:22 -0500
Received: from ns.firmix.at ([62.141.48.66]:36546 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751349AbVKIJXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 04:23:22 -0500
Subject: Re: typedefs and structs
From: Bernd Petrovitsch <bernd@firmix.at>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org
In-Reply-To: <1131492815.14381.184.camel@localhost.localdomain>
References: <20051105061114.GA27016@kroah.com>
	 <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
	 <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com>
	 <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com>
	 <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com>
	 <20051107204136.GG19593@austin.ibm.com>
	 <1131412273.14381.142.camel@localhost.localdomain>
	 <20051108232327.GA19593@austin.ibm.com>
	 <1131492815.14381.184.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 09 Nov 2005 10:22:42 +0100
Message-Id: <1131528162.19171.14.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 18:33 -0500, Steven Rostedt wrote:
> On Tue, 2005-11-08 at 17:23 -0600, linas wrote:
> > On Mon, Nov 07, 2005 at 08:11:13PM -0500, Steven Rostedt was heard to remark:
> > > On Mon, 2005-11-07 at 14:41 -0600, linas wrote:
> > > 
> > > don't use typedef to get rid of "struct".
> > > 
> > > This was for the simple reason, too many developers were passing
> > > structures by value instead of by reference, just because they were
> > > using a type that they didn't realize was a structure. 
> > 
> > That's a rather bizarre mistake to make, since, in order to 
> > access a values in such a beast, you have to use a dot . instead 
> > of an arrow -> and so it hits ou in the face that you passed a value
> > instead of a reference.

And for every access of a field with a . you also look if it is not a
locally declared (small) struct?

> It happens when you access the variable via macros and other routines
> that you notice that takes and address of the variable, so you just pass
> in the address of the current local variable.
> > ----
> > Off-topic: There's actually a neat little trick in C++ that can 
> > help avoid accidentally passing null pointers.  One can declare 

And if you want a NULL-pointer equivalent, you declared a defined
null_blah object just to have a reference.
I've seen that often enough.
If want to avoid accidental NULL pointers, use "splint" or similar
tools. Or add an BUG_ON().

> > function declarations as:
> > 
> >   int func (sturct blah &v) {
> >     v.a ++; 
> >     return v.b;
> >   }
> > 
> > The ampersand says "pass argument by reference (so as to get arg passing
> > efficiency) but force coder to write code as if they were passing by value"
> > As a result, it gets difficult to pass null pointers (for reasons
> > similar to the difficulty of passing null pointers in Java (and yes,

See above for NULL-pointer equivalents.

> > I loathe Java, sorry to subject you to that))  Anyway, that's a C++ trick 
> > only; I wish it was in C so I could experiment more and find out if I 

No, it's not a trick butt an ordinary language feature.
And no, it was already in several Pascal's decades ago.

> > like it or hate it.
> 
> Actually, the true pass by reference (not by pointer) is one of the
> things that C++ has, that I wish C had.

No, you probably don't because if you forget one of the & in a call
chain (or even worse: it is removed for whatever bizarre reason), you
might get interesting bugs to hunt. And C++ is also much more creative
with temporaries which are simply thrown away afterwards.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

