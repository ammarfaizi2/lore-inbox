Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131218AbQLUSuC>; Thu, 21 Dec 2000 13:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbQLUStw>; Thu, 21 Dec 2000 13:49:52 -0500
Received: from janus.cypress.com ([157.95.1.1]:53944 "EHLO janus.cypress.com")
	by vger.kernel.org with ESMTP id <S131218AbQLUStf>;
	Thu, 21 Dec 2000 13:49:35 -0500
Message-ID: <3A424990.7CDA4A2C@cypress.com>
Date: Thu, 21 Dec 2000 12:18:56 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 signal.h
In-Reply-To: <20001215195433.G17781@inspiron.random> <Pine.LNX.4.21.0012151752421.3596-100000@duckman.distro.conectiva> <20001215211404.J17781@inspiron.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Fri, Dec 15, 2000 at 05:55:08PM -0200, Rik van Riel wrote:
> > On Fri, 15 Dec 2000, Andrea Arcangeli wrote:
> >
> > > x()
> > > {
> > >
> > >     switch (1) {
> > >     case 0:
> > >     case 1:
> > >     case 2:
> > >     case 3:
> > >     ;
> > >     }
> > > }
> > >
> > > Why am I required to put a `;' only in the last case and not in
> > > all the previous ones?
> >
> > That `;' above is NOT in just the last one. In your above
> > example, all the labels will execute the same `;' statement.
> >
> > In fact, the default behaviour of the switch() operation is
> > to fall through to the next defined label and you have to put
> > in an explicit `break;' if you want to prevent `case 0:' from
> > reaching the `;' below the `case 3:'...
> 
> Are you kidding me?

Absolutely NOT.

switch (x) {
  case 0:
  case 1:
      printf ("%d\n", x);
      break;
  case 2:
      printf ("%d\n",x*x);
  case 3:
      printf ("%d\n", x*x*x);
 }

if x==0 or 1, prints x (the 0 or one),
if x==2 , it prints 4 and 8  since no break statement exits the switch,
if x==3, it prints only 27,
any othe value of x, and nothing is printed.

Every C compile I have ever used does this.
Sun's C and C++, HP's C, Microsoft's VC++, Borland's C, and all versions
of gcc and g++.

Grab any C programming book, and find the switch statement.

	-Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
