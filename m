Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130874AbRBUAMl>; Tue, 20 Feb 2001 19:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130894AbRBUAMb>; Tue, 20 Feb 2001 19:12:31 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:11909 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130874AbRBUAM0>; Tue, 20 Feb 2001 19:12:26 -0500
Date: Wed, 21 Feb 2001 01:13:03 +0100
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
Message-ID: <20010221011303.A3045@storm.local>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca> <m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com> <m1k86s6imn.fsf@frodo.biederman.org> <20010217084330.A17398@cadcamlab.org> <m1y9v4382r.fsf@frodo.biederman.org> <20010220021012.A1481@storm.local> <200102200909.KAA12190@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102200909.KAA12190@microsoft.com>; from xavier.bestel@free.fr on Tue, Feb 20, 2001 at 10:09:55AM +0100
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 10:09:55AM +0100, Xavier Bestel wrote:
> Le 20 Feb 2001 02:10:12 +0100, Andreas Bombe a écrit :
> > On Sat, Feb 17, 2001 at 09:53:48PM -0700, Eric W. Biederman wrote:
> > > Peter Samuelson <peter@cadcamlab.org> writes:
> > > > It also sounds like you will be
> > > > breaking the extremely useful C postulate that, at the ABI level at
> > > > least, arrays and pointers are equivalent.  I can't see *how* you plan
> > > > to work around that one.
> > > 
> > > Huh?  Pointers and arrays are clearly different at the ABI level.
> > > 
> > > A pointer is a word that contains an address of something.
> > > An array is an array.
> > 
> > An array is a word that contains the address of the first element.
> 
> 
> No. Exercise 3: compile and run this:
> file a.c:
> char array[] = "I'm really an array";
> 
> file b.c:
> extern char* array;
>
> main() { printf("array = %s\n", array); }
> 
> ... and watch it biting the dust !

Deliberately linking to the wrong symbol is not a point.  Might as well
replace file a.c with "int array = 0;".  That'll also bite the dust.  So?

> in short: an array is NOT a pointer.

In this context we were talking *function calls*, not confusing the
linker.  And whether you say "char array[];" or "char *const array;",
array is a pointer.  Even more so at the ABI = function call interface.

Another try:  Assume that
	#include "secret.h"
	int main() { printf("array = %s\n", array); return 0; }
is correct code.

Is the variable array a pointer to a char or an array of chars?

Oh well, who cares.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
