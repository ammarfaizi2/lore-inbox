Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285052AbRLQJEd>; Mon, 17 Dec 2001 04:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285055AbRLQJEX>; Mon, 17 Dec 2001 04:04:23 -0500
Received: from elin.scali.no ([62.70.89.10]:15364 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S285052AbRLQJET> convert rfc822-to-8bit;
	Mon, 17 Dec 2001 04:04:19 -0500
Subject: Re: O_DIRECT wierd behavior..
From: Terje Eggestad <terje.eggestad@scali.no>
To: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>
Cc: Andrew Morton <akpm@zip.com.au>, GOTO Masanori <gotom@debian.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.GSO.4.02A.10112161208160.25791-100000@aramis.rutgers.edu>
In-Reply-To: <Pine.GSO.4.02A.10112161208160.25791-100000@aramis.rutgers.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 10:04:07 +0100
Message-Id: <1008579848.12274.0.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone, wonder if it wasn't Andrea, pointet out to me that it should be
device block size, not page size for alignment and length.
Appearently it was just simpler to do page alignment, don't expect a
patch for that in any immediate future. 

Other than that; you've got it.

TJ

 
søn, 2001-12-16 kl. 18:43 skrev Suresh Gopalakrishnan:
> 
> On Sun, 16 Dec 2001, Terje Eggestad wrote:
> > The problem is that the kernel that don't support O_DIRECT has
> > erronous handling of the O_DIRECT flag. Meaning they happily accept
> > it. In order to figure out ifthe running kernel support O_DIRECT you
> > MUST attempt an unaligned read/write, if it succed the kernel DON'T
> > support O_DIRECT. TJ
> 
> You are right! It went through on 2.4.2 even with an unaligned buffer.
> 
> So direct i/o has to be multiple of page size blocks, from page aligned
> buffer, and apparently into page aligned offset in the file! Is this the
> expected behavior?
> 
> --suresh
> 
> > > Thanks for the patches. There seems to be one more fix required: the test
> > > program below works in 2.4.16 only if the write size is a multiple of 4K.
> > > (Why) are all writes expected to be page size, in addition to being page
> > > aligned? (It works fine on 2.4.2 for all sizes). Any quick fixes? :)
> > > --suresh
> 
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

