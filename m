Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTBKKN4>; Tue, 11 Feb 2003 05:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTBKKN4>; Tue, 11 Feb 2003 05:13:56 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:29707 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267356AbTBKKNz>; Tue, 11 Feb 2003 05:13:55 -0500
Message-ID: <3E48CF66.DC8B7F13@aitel.hist.no>
Date: Tue, 11 Feb 2003 11:24:38 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org, Art Haas <ahaas@airmail.net>
Subject: Re: Is -fno-strict-aliasing still needed?
References: <200302110714.h1B7EA3A006209@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Art Haas <ahaas@airmail.net> said:
> > I ask because I've just built a kernel without using that flag -
> > linus-2.5 BK from this morning, probably missing the 2.5.60 release by
> > a few hours.
> 
> The problem with strict aliasing is that it allows the compiler to assume
> that in:
> 
>      void somefunc(int *foo, int *bar)
> 
> foo and bar will _*never*_ point to the same memory area (at the same
> struct, or into the same array, etc). There is no way to check for this in
> the compiler in general (the function and the call might be in different
> files, many functions are being called via pointers, ...).

I though pointers to the same type, such as int *, could alias still.

But pointers to different types, such as int* and short* is assumed
to never clash with strict aliasing.  And this bites linux
because it sometimes choose to see "two adjacent shorts as one int" for
performance reasons.  

I remember the flag was introduced because some IP or TCP
code do exactly this, and converting it all to unions would
render that code unreadable.

Helge Hafting
