Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272656AbRHaKMi>; Fri, 31 Aug 2001 06:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272657AbRHaKMS>; Fri, 31 Aug 2001 06:12:18 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:26632 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S272656AbRHaKMM>; Fri, 31 Aug 2001 06:12:12 -0400
Message-ID: <3B8F62B2.6C8BC613@idb.hist.no>
Date: Fri, 31 Aug 2001 12:10:58 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>, graham@barnowl.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com> <20010830165447Z16272-32385+540@humbolt.nl.linux.org> <m266b51c5c.fsf@barnowl.demon.co.uk> <20010830234659.B14715@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> On Thu, Aug 30, 2001 at 09:16:47PM +0000, Graham Murray wrote:
> > Daniel Phillips <phillips@bonn-fries.net> writes:
> >
> > > More than anything, it shows that education is needed, not macro patch-ups.
> > > We have exactly the same issues with < and >, should we introduce
> > > three-argument macros to replace them?
> >
> > Would it not have been much more "obvious" if the rules for
> > unsigned/signed integer comparisons (irrespective of the widths
> > involved) were
> >
> > 1) If the signed element is negative then it is always less than the
> >    unsigned element.
> >
> > 2) If the unsigned element is greater than then maximum positive value
> >    expressible by the signed one then it is always greater.
> >
> > 3) Only if both values are positive and within the range of the
> >    smaller element are the actual values compared.
> 
> Possibly, but changing the C specification is not really an option here...

Even worse: most microprosessors don't do comparisons that way.
They compare either two signed or two unsigned 
items and do that reasonably fast.  This is why C also works this way.

A compiler can be made to use the above standard, but it would generate
slow code for all signed/unsigned compares because now there is
3 tests instead of one.  This is why language designers don't do that.

You can of course do this explicitly in code if you need that
sort of comparison, e.g.

signed a;
unsigned b;
if (a<0) case1() 
   else if (b>MAX_SIGNED) case2()
   else if (a<b) case1() else case2();


A nice feature of C is that ugly time-consuming stuff tends to
look ugly and time-consuming in code too.  So it is easier
to avoid. :-)

Helge Hafting
