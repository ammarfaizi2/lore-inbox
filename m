Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbREHHw6>; Tue, 8 May 2001 03:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbREHHws>; Tue, 8 May 2001 03:52:48 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:59922 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S131460AbREHHwg>; Tue, 8 May 2001 03:52:36 -0400
Message-ID: <3AF7A5AF.789AC083@idb.hist.no>
Date: Tue, 08 May 2001 09:52:15 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus> <3AF663F1.E04D90CE@idb.hist.no> <20010507210229.A7724@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On 05.07 Helge Hafting wrote:

> > !0 is 1.  !(anything else) is 0.  It is zero and one, not
> > zero and "non-zero".  So a !! construction gives zero if you have
> > zero, and one if you had anything else.  There's no doubt about it.
> > >
> 
> Isn't this asking for trouble with the optimizer ? It could kill both
> !!. Using that is like trusting on a certain struct padding-alignment.

No, this won't cause trouble with the optimizer, because the
optimizer isn't supposed to do _wrong_ things.

The optimizer will not remove two !! in a row, simply because that
_isn't_ a valid optimization as you just have seen.  
"!" is a logical not, it isn't a bitwise not.  The result of
!!(something)
is different from just (something) whenever (something) is
neither 0 or 1, the optimizer knows that very well.

Use gcc -S to get readable assembly.
Try these yourself, they compile to different code:
int main(int argc){return argc;}
int main(int argc){return !!argc;}
They have to be different, as argc >= 2 gives different results.

And try:
int main(int argc){return !argc;}
int main(int argc){return !!!argc;}

These gives the same code with or without optimization with
gcc 2.95.4 on i386, as they are equivalent.  The first ! normalize
to 1 or 0, the two others are then removeable.

Helge Hafting
