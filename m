Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTLUWxG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 17:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTLUWxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 17:53:06 -0500
Received: from mail.shareable.org ([81.29.64.88]:2696 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264246AbTLUWw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 17:52:59 -0500
Date: Sun, 21 Dec 2003 22:51:50 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Karim Yaghmour <karim@opersys.com>, yodaiken@fsmlabs.com,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating real-time and nanokernel maintainersy
Message-ID: <20031221225150.GB6507@mail.shareable.org>
References: <Pine.LNX.4.58.0312181821270.19491@montezuma.fsmlabs.com> <3FE23966.7060001@opersys.com> <Pine.LNX.4.58.0312181836360.19491@montezuma.fsmlabs.com> <3FE23CD1.4080802@opersys.com> <3FE23E3F.2000801@cyberone.com.au> <3FE2424B.70901@opersys.com> <20031219094122.GA23469@wohnheim.fh-wedel.de> <20031221082736.GA11795@hq.fsmlabs.com> <3FE5F2E6.8030002@opersys.com> <Pine.LNX.4.58.0312211145490.13039@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312211145490.13039@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> There are several cases where this came up: RCU is one obvious one, but 
> there were also issues with Intel's initial submissions of some of the 
> networking drivers where they didn't want to originally release under the 
> GPL because of worrying about patents they owned.

It's commonly understood that patents licensed to _all_ GPL'd projects
are ok by the GPL, but when they are limited to _specific_ GPL'd
projects they would violate the GPL.

So for example it would not be acceptable _if_ Red Hat's patents were
licensed just for Red Hat Linux, but it's fine because Red Hat
licenses its patents for all GPL projects.

In the Linux kernel, 2.6.0, I see two minor problems and one major.
First the minors:

   1. Code under arch/m68k contains this notice:

          You are hereby granted a copyright license to use, modify,
          and distribute the SOFTWARE so long as this entire notice is
          retained without alteration in any modified and/or
          redistributed versions, and that such modified versions are
          clearly identified as such.  No licenses are granted by
          implication, estoppel or otherwise under any patents or
          trademarks of Motorola, Inc.

     The copyright is a BSD-like license, no problem there.
     But the part about patent licenses appears to either contradict the
     GPL, or imply that there are no patents to license anyway.

  2. Documentation/sound/alsa/SB-Live-mixer.txt draws our attention to
     10 patents that are relevant to the SB-Live-mixer implementation.

     It doesn't say we're licensed to use them.

  3. The MTD flash translation layer patent(s) may not be acceptably
     licensed.  It's obvious that they are against the spirit of GPL;
     I'm not sure if they satisfy the letter, and that's after
     reading the GPL carefully (but I'm not a lawyer).  From
     drivers/mtd/ftl.c:

          LEGAL NOTE: The FTL format is patented by M-Systems.  They have
          granted a license for its use with PCMCIA devices:

           "M-Systems grants a royalty-free, non-exclusive license under
            any presently existing M-Systems intellectual property rights
            necessary for the design and development of FTL-compatible
            drivers, file systems and utilities using the data formats
            with PCMCIA PC Cards as described in the PCMCIA Flash
            Translation Layer (FTL) Specification."

          Use of the FTL format for non-PCMCIA applications may be an
          infringement of these patents.  For additional information,
          contact M-Systems (http://www.m-sys.com) directly.

     The difficulty is that a person is not free to use the code in
     ftl.c (and some other files) on any computer they want, nor to
     take the code and use it in other ways.

     This paragraph is from the the preamble of the GPL:

            Finally, any free program is threatened constantly by
          software patents.  We wish to avoid the danger that
          redistributors of a free program will individually obtain
          patent licenses, in effect making the program proprietary.
          To prevent this, we have made it clear that any patent must
                                                      ~~~~~~~~~~~~~~~
          be licensed for everyone's free use or not licensed at all.
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     It isn't clearly stated whether that means everyone's free use
     generally, or everyone's free use provided they are only using it
     on a PCMCIA device.

     If the latter is permitted, then I hazard that everyone's free
     use provided they are only using it on Red Hat Linux is also
     permitted.  That sounds absurd, so by reductio ad absurdum
     the MTD license is _not_ sufficient license to include the code
     in drivers/mtd/ in any GPL project, including Linux.

Finally, the config help entry for CONFIG_FTL has this to say:

          You may find that the algorithms used in this code are
          patented unless you live in the Free World where software
          patents aren't legal - in the USA you are only permitted to
          use this on PCMCIA hardware, although under the terms of the
          GPL you're obviously permitted to copy, modify and
          distribute the code as you wish. Just not use it.
                                           ~~~~~~~~~~~~~~~

If the author is correct, then it _is_ permitted to copy, modify and
distribute code, and the patent restriction comes into play _only_
when the code is used.  In other words, distributing GPL'd source
which has patent-infringing uses is fine for the distributor; only the
person who uses the code is infringing and may be liable.

However I venture to suggest the author of the config help entry is
not a lawyer either, and we should not take his words too precisely.

-- Jamie
