Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbREULeY>; Mon, 21 May 2001 07:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262489AbREULeF>; Mon, 21 May 2001 07:34:05 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:11510 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262488AbREULeD>; Mon, 21 May 2001 07:34:03 -0400
Message-Id: <l03130304b72ea286711e@[192.168.239.105]>
In-Reply-To: <3B08DC75.C466BA66@idb.hist.no>
In-Reply-To: <20010518105353.A13684@thyrsus.com>
 <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com>
 <20010518113726.A29617@devserv.devel.redhat.com>
 <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com>
 <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com>
 <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com>
 <20010520131457.A3769@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 21 May 2001 12:32:49 +0100
To: Helge Hafting <helgehaf@idb.hist.no>, esr@thyrsus.com
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Background to the argument about CML2 design philosophy
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> order to hold down ruleset complexity and simplify the user
>> experience.  The cost of deciding that the answer to that question is
>
>The user experience can be simplified by a NOVICE/EASY/SANE_DEFAULTS
>option, and perhaps a HACKER option for the really strange
>but _theoretically_ ok stuff.

Having now briefly looked at the language constructs first-hand, I can see
two ways to go about this:

1) Have a HACKER symbol which unsuppresses the "unusual" options, and
suppresses the "generalised" ones (like: "build all the sound drivers for
my hardware, as modules").  This is kinda how it would be implemented in
CML1, cf. EXPERIMENTAL.

2) Have a HACKERS submenu system which contains all the derivations that
could *possibly* be un-defaulted, and allow our intrepid hacker to
explicitly force each to a value or leave unset.  Leaving unset means the
derivation holds, forcing it to a value will explicitly enable or disable
the option along with any hard dependencies.  Head this submenu system with
a big banner that says "FOR EXPERTS ONLY", or suppress it using an
"Experts" switch.

Is there already a language construct to support the difference between a
"derivation" and a "dependency"?  Yes, it's the difference between "unless
FOO==n default BAR==y" and "require FOO!=n implies BAR==y" respectively (or
something to that effect, if my syntax is wrong flame gently please!).
With that in mind, the front-end UI could implement Option 2 easily, by
presenting a mode which automatically collects defaulted but otherwise
hidden symbols, and reveals them to the user when set to "hacker" mode.

I'm going to assume for now that CML2 saves two files - one storing a
relatively small number of symbols (which is strictly limited to those
explicitly set by the user), and one containing the full set for
consumption by the Makefiles.  If this is the case, then if a "hacker" type
switches something explicitly then it'll stay there even if the default
changes for that option in a future kernel.  Meanwhile, Aunt Tillie gets
the changed default option applied with no extra effort.  "make oldconfig"
might as well be a thing of the past for certain purposes, although it
should still be kept as a way of reminding people what the new options are.

Incidentally, in this scenario, if we have "enable driver for device FOOBAR
[NEW] [y/m/N]:" then pressing Return should *not* mark the symbol as
"explicitly set" but left alone because "user accepted the default".  If
they pressed "N", then that has the same effect but is saved explicitly for
future kernels, regardless of any defaults change for that option.

Hope this makes sense and I'm not being a stark raving loonie...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


