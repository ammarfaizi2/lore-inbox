Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129634AbRBUJbw>; Wed, 21 Feb 2001 04:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130297AbRBUJbm>; Wed, 21 Feb 2001 04:31:42 -0500
Received: from nas3-182.wms.club-internet.fr ([213.44.30.182]:29426 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129634AbRBUJbf>;
	Wed, 21 Feb 2001 04:31:35 -0500
Message-Id: <200102210930.KAA14861@microsoft.com>
Subject: Re: Is this the ultimate stack-smash fix?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010221011303.A3045@storm.local>
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>  
	<m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca>  
	<m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com>  
	<m1k86s6imn.fsf@frodo.biederman.org> <20010217084330.A17398@cadcamlab.org>  
	<m1y9v4382r.fsf@frodo.biederman.org> <20010220021012.A1481@storm.local>  
	<200102200909.KAA12190@microsoft.com>  <20010221011303.A3045@storm.local>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.8 - Preview Release)
Date: 21 Feb 2001 10:30:36 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21 Feb 2001 01:13:03 +0100, Andreas Bombe a écrit :
> On Tue, Feb 20, 2001 at 10:09:55AM +0100, Xavier Bestel wrote:
> > Le 20 Feb 2001 02:10:12 +0100, Andreas Bombe a écrit :
> > > On Sat, Feb 17, 2001 at 09:53:48PM -0700, Eric W. Biederman wrote:
> > > > Peter Samuelson <peter@cadcamlab.org> writes:
> > > > > It also sounds like you will be
> > > > > breaking the extremely useful C postulate that, at the ABI level at
> > > > > least, arrays and pointers are equivalent.  I can't see *how* you plan
> > > > > to work around that one.
> > > > 
> > > > Huh?  Pointers and arrays are clearly different at the ABI level.
> > > > 
> > > > A pointer is a word that contains an address of something.
> > > > An array is an array.
> > > 
> > > An array is a word that contains the address of the first element.
> > 
> > 
> > No. Exercise 3: compile and run this:
> > file a.c:
> > char array[] = "I'm really an array";
> > 
> > file b.c:
> > extern char* array;
> >
> > main() { printf("array = %s\n", array); }
> > 
> > ... and watch it biting the dust !
> 
> Deliberately linking to the wrong symbol is not a point.  Might as well
> replace file a.c with "int array = 0;".  That'll also bite the dust.  So?
> 
> > in short: an array is NOT a pointer.
> 
> In this context we were talking *function calls*, not confusing the
> linker.  And whether you say "char array[];" or "char *const array;",
> array is a pointer.  Even more so at the ABI = function call interface.

OK, I missed this. There are no arrays in the function call interface,
they are promoted to pointers.

Xav

