Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291539AbSBAE1F>; Thu, 31 Jan 2002 23:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291540AbSBAE04>; Thu, 31 Jan 2002 23:26:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16258 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291539AbSBAE0q>;
	Thu, 31 Jan 2002 23:26:46 -0500
Date: Thu, 31 Jan 2002 20:25:09 -0800 (PST)
Message-Id: <20020131.202509.78710127.davem@redhat.com>
To: garzik@havoc.gtf.org
Cc: alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020131224635.F21864@havoc.gtf.org>
In-Reply-To: <E16WRmu-0003iO-00@the-village.bc.nu>
	<20020131.163054.41634626.davem@redhat.com>
	<20020131224635.F21864@havoc.gtf.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <garzik@havoc.gtf.org>
   Date: Thu, 31 Jan 2002 22:46:35 -0500
   
   Maybe not in this hypothetical future situation, but currently makefile
   magic was added for crc32 specifically to ensure that it is linked
   in when needed... even when CONFIG_CRC32=n.
   
   The Config.in for crc32 only exists for the case where no driver in the
   built kernel uses it... but a 3rd party module might want it.
   
My point is this: Having to say something like "CONFIG_INEED_CRC32"
for each driver that needs it is just plain stupid and a total eye
sore.

It would be really great if, some day, you just add your source
file(s) to drivers/net and that is the only thing you ever touch.  You
DO NOT touch Makefiles, you DO NOT touch Config.in files, you DO NOT
add Config.help entries.

The Makefile rules are auto-generated from keys in the *.c file(s), as
are the Config.in and help entries.  Ie. cp driver.[ch]
linux/drivers/net and then simply rebuild the tree.

Think of what kind of pains this would save from a maintainership
point of view.  When multiple new drivers are added at once we run
into all kinds of conflict issues today, whereas my scheme would do
away with that for all cases except totally new subsystems. (but I
think that could be automated in a similar fashion as well)

I have this feeling Keith Owens is going to scream "the new build
system DOES EXACTLY THAT!"  If so, that's fscking great. :-)

That is the kind of direction I'd like to see things going in.  The
lib config thing checking "if LANCE or 8130TOO or ... then force CRC32
on", on the other hand, is just garbage.  It is rediculious to expect
J. Random driver author to know to put junk into weird places like
that just to get at the crc32 routines.
