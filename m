Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130282AbRBRHFz>; Sun, 18 Feb 2001 02:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132187AbRBRHFp>; Sun, 18 Feb 2001 02:05:45 -0500
Received: from slc369.modem.xmission.com ([166.70.2.115]:41992 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130282AbRBRHFa>; Sun, 18 Feb 2001 02:05:30 -0500
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca> <m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com> <m1k86s6imn.fsf@frodo.biederman.org> <20010217084330.A17398@cadcamlab.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Feb 2001 21:53:48 -0700
In-Reply-To: Peter Samuelson's message of "Sat, 17 Feb 2001 08:43:30 -0600"
Message-ID: <m1y9v4382r.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org> writes:

>   [Manfred Spraul]
> > > Unless you modify the ABI and pass the array bounds around you won't
> > > catch such problems, 
> 
> [Eric W. Biederman]
> > Of course.  But this is linux and you have the source.  And I did
> > mention you needed to recompile the libraries your trusted
> > applications depended on.
> 
> So by what ABI do you propose to pass array bounds to a called
> function?  It sounds pretty ugly.  

Not especially.  In cases you can't optimize pointers become tuples
of <pointer to the array, pointer one past the end of the array, real pointer>.

> It also sounds like you will be
> breaking the extremely useful C postulate that, at the ABI level at
> least, arrays and pointers are equivalent.  I can't see *how* you plan
> to work around that one.

Huh?  Pointers and arrays are clearly different at the ABI level.

A pointer is a word that contains an address of something.
An array is an array.

There is an implicit promotion from one to the other at the source level,
but that has little to do with the application binary interface.

> > Yep bounds checking is not an easy fix.
> 
> Understatement of the year, if you really want to catch all cases.

No, it's more of a large mechanical job than truly hard problem.
The real challenge lies in optimizing out the checks so you don't penalize
the inner loops of code.

Eric

