Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRHEGpM>; Sun, 5 Aug 2001 02:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269927AbRHEGpD>; Sun, 5 Aug 2001 02:45:03 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:29420 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S269926AbRHEGon>; Sun, 5 Aug 2001 02:44:43 -0400
Subject: Re: /proc/<n>/maps getting _VERY_ long
From: David Luyer <david_luyer@pacific.net.au>
To: linux-kernel@vger.kernel.org
Cc: Chris Wedgwood <cw@f00f.org>, riel@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 05 Aug 2001 16:44:26 +1000
Message-Id: <996993866.741.11.camel@typhaon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote (off-list):
> On 05 Aug 2001 17:12:02 +1200, Chris Wedgwood wrote:
> > On Sat, Aug 04, 2001 at 11:17:26PM -0300, Rik van Riel wrote:
> >
> >     > cw:tty5@tapu(cw)$ wc -l /proc/1368/maps
> >     >    5287 /proc/1368/maps
> >
> >     Ouch, what kind of application is this happening with ?
> >
> > Mozilla.  Presumably some of the Gnome applications might be the same
> > as they use lots and lots of shared libraries (anyone out there Gnome
> > inflicted and can check?).
>
> FYI: Linux 2.2.14 (yes, I know, it's old but I've had no cause to update
> the machine in question):
>
> Mozilla: 215 lines in /proc/$$/maps
> StarOffice opening a small PowerPoint: 209 lines in /proc/$$/maps
> Evolution Mail Component: 193 lines in /proc/$$/maps
>
> Those are the current 'winners' on my wc -l /proc/*/maps | sort -n but
> I'm not exactly doing anything to stress the machine.  Hard to know if
> the 2.2.x number of mappings will have any correlation with 2.4.x (as
> if 2.4.x isn't aggressive combining ranges but both allocate initially
> as well as each other, it might get a lot worse with long-running
> processes on 2.4.x but not on 2.2.x, for example).

And the same machine, 2.4.7ac5:

Mozilla: 222 lines in /proc/$$/maps on startup... and growing
StarOffice opening a small PowerPoint: 209 lines in /proc/$$/maps
Evolution Mail Component: 181 lines in /proc/$$/maps

But after visiting a few web pages Mozilla has already grown to 265 mappings;
302 mappings; growing... (whereas playing around in Evolution Mail only
increased it's number to 185.. actually as I finish off this mail and have
done a few other things it's up to 222 now).

So the problem is something which Mozilla is particularly good at triggering.
Under 2.2.14 the number of mappings for Mozilla wasn't growing significantly
with use.  But that doesn't say that it isn't some kind of 'bad' behaviour
from Mozilla.

Here's some sample mappings for evolution-mail:

40f10000-40f11000 rw-p 000cf000 00:00 0
40f11000-40f12000 rw-p 000d0000 00:00 0
40f12000-40f13000 rw-p 000d1000 00:00 0
40f13000-40f14000 rw-p 000d2000 00:00 0
40f14000-40f15000 rw-p 000d3000 00:00 0
40f15000-40f16000 rw-p 000d4000 00:00 0
40f16000-40f17000 rw-p 000d5000 00:00 0
40f17000-40f19000 rw-p 000d6000 00:00 0
40f19000-40f1a000 rw-p 000d8000 00:00 0
40f1a000-40f1d000 rw-p 000d9000 00:00 0
40f1d000-40f25000 rw-p 000dc000 00:00 0
40f25000-40f26000 rw-p 000e4000 00:00 0
40f26000-40f27000 rw-p 000e5000 00:00 0
[...]

Now I would naievely assume those adjacent contiguous mappings with equal
permissions could pretty easily be merged.

David.
-- 
David Luyer                                     Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                      NASDAQ:  PCNTF
