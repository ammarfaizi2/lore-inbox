Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRKDTpX>; Sun, 4 Nov 2001 14:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRKDTpO>; Sun, 4 Nov 2001 14:45:14 -0500
Received: from unthought.net ([212.97.129.24]:57304 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S274875AbRKDTpD>;
	Sun, 4 Nov 2001 14:45:03 -0500
Date: Sun, 4 Nov 2001 20:45:02 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104204502.O14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	Alexander Viro <viro@math.psu.edu>,
	John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
	Daniel Phillips <phillips@bonn-fries.net>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <20011104200452.L14001@unthought.net> <620744650.1004901876@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <620744650.1004901876@[195.224.237.69]>; from linux-kernel@alex.org.uk on Sun, Nov 04, 2001 at 07:24:36PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:24:36PM -0000, Alex Bligh - linux-kernel wrote:
> 
> 
> --On Sunday, 04 November, 2001 8:04 PM +0100 Jakob Østergaard 
> <jakob@unthought.net> wrote:
> 
> > I'm a little scared when our VFS guy claims he never heard of excellent
> > programmers using scanf in a way that led to parse errors.
> 
> I'd be far more scared if Al claimed he'd never heard of excellent
> programmers reading binary formats, compatible between multiple
> code revisions both forward and backwards, endian-ness etc., which
> had never lead to parse errors of the binary structure.

Sure there is potential for error anywhere.  And maybe your compiler's
type-check is broken too.  But that's not an argument for not trying
to improve on things.

Please tell me,  is "1610612736" a 32-bit integer, a 64-bit integer, is
it signed or unsigned   ?

I could even live with parsing ASCII, as long as there'd just be type
information to go with the values.  But I see no point in using ASCII
for something intended purely for machine-to-machine communication.

/proc text "GUI" files will stay, don't worry  :)

> If you feel it's too hard to write use scanf(), use sh, awk, perl
> etc. which all have their own implementations that appear to have
> served UNIX quite well for a long while.

Witness ten lines of vmstat output taking 300+ millions of clock cycles.

> Constructive suggestions:
> 
> 1. use a textual format, make minimal
>    changes from current (duplicate new stuff where necessary),
>    but ensure each /proc interface has something which spits
>    out a format line (header line or whatever, perhaps an
>    interface version number). This at least
>    means that userspace tools can check this against known
>    previous formats, and don't have to be clairvoyant to
>    tell what future kernels have the same /proc interfaces.

Then we have text strings as values - some with spaces, some with quotes in
them.   Then we escape our way out of that (which isn't done today by the way),
and then we start implementing a parser for that in every /proc using
application out there.

These interfaces need to be "correct", not "mostly correct".

Example:   I make a symlink from "cat" to "c)(t" (sick example, but that doesn't
change my point), and do a "./c)(t /proc/self/stat":

[albatros:joe] $ ./c\)\(a /proc/self/stat
22482 (c)(a) R 22444 22482 22444 34816 22482 0 20 0 126 0 0 0 0 0 14 0 0 0 24933425 1654784 129 4294967295 134512640 134525684 3221223504 3221223112 1074798884 0 0 0 0 0 0 0 17 0

Go parse that one !  What's the name of my applications ? 

It's good enough for human readers - we have the ability to reason and
make qualified quesses.   Now go implement that in every single piece of
/proc reading software out there   :)

If you want ASCII, we should at least have some approved parsing library
to parse this into native-machine binary structures that can be used 
safely in applications.  I see little point in ASCII then, but maybe it's
just me.

> 
> 2. Flag those entries which are sysctl mirrors as such
>    (perhaps in each /proc directory /proc/foo/bar/, a
>    /proc/foo/bar/ctl with them all in). Duplicate for the
>    time being rather than move. Make reading them (at
>    least those in the ctl directory) have a comment line
>    starting with a '#' at the top describing the format
>    (integer, boolean, string, whatever), what it does.
>    Ignore comment lines on write.
> 
> 3. Try and rearrange all the /proc entries this way, which
>    means sysctl can be implemented by a straight ASCII
>    write - nice and easy to parse files. Accept that some
>    /proc reads (especially) are going to be hard.

I just hate to implement a fuzzy parser with an A.I. that makes HAL look like
kid's toys, every d*mn time I need to get information from the system.

I'm not a big fan of huge re-arrangements. I do like the idea of providing
a machine-readable version of /proc.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
