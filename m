Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTJHI2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 04:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTJHI2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 04:28:15 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7590 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261326AbTJHI2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 04:28:12 -0400
Date: Wed, 8 Oct 2003 10:28:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: keyboard repeat speed went nuts since 2.6.0-test5, even in 2.6.0-test6-mm4
Message-ID: <20031008082806.GA23340@ucw.cz>
References: <20031007203316.GA1719@middle.of.nowhere> <20031007204056.GB20844@ucw.cz> <20031008082346.GA1628@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20031008082346.GA1628@middle.of.nowhere>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2003 at 10:23:46AM +0200, Jurriaan wrote:
> From: Vojtech Pavlik <vojtech@suse.cz>
> Date: Tue, Oct 07, 2003 at 10:40:56PM +0200
> > On Tue, Oct 07, 2003 at 10:33:16PM +0200, Jurriaan wrote:
> > > I like my keyboard fast (must be from playing a lot of angband).
> > > 
> > > In 2.6.0-test5, after '/sbin/kbdrate -r 30 -d 250', I get some 2000
> > > characters in a minute (pressing n continuously, stopwatch in hand).
> > > In 2.6.0-test6 and 2.6.0-test6-mm4, after '/sbin/kbdrate -r 30 -d 250',
> > > I get some 820 characters in a minute.
> > > 
> > > 30 cps != 800/60 s, that's more like half that rate.
> > > 
> > > Booting with or without atkbd_softrepeat=1 on the kernel commandline
> > > makes no difference at all.
> > 
> > It's a bug. I have a fix, it went through LKML already, but Linus
> > didn't merge it yet. I'll be resending it.
> > 
> > > It's not only the repeat-speed that has gone down, the delay before
> > > repeat kicks in is notably slower as well. This is perhaps even more
> > > frustrating, but harder to measure :-(
> > > 
> > > This is on a plain Chicony KB-7903 PS/2 keyboard. It is connected via a
> > > Vista Rose KVM to a VIA KT400 chipset motherboard.
> > > 
> > > Any patches to test are very welcome here.
> > 
> > Fix attached.
> > 
> Sorry, but that fix is already in 2.6.0-test6-mm4; that's why I tested
> that version...

Yet another bug. Fix attached, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=softrepeat

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1340.1.2, 2003-09-28 18:48:05+02:00, vojtech@suse.cz
  input: Fix atkbd_softrepeat kernel command line parameter.


 atkbd.c |    8 ++++++++
 1 files changed, 8 insertions(+)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Oct  8 10:27:57 2003
+++ b/drivers/input/keyboard/atkbd.c	Wed Oct  8 10:27:57 2003
@@ -707,9 +707,17 @@
         if (ints[0] > 0) atkbd_reset = ints[1];
         return 1;
 }
+static int __init atkbd_setup_softrepeat(char *str)
+{
+        int ints[4];
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0) atkbd_softrepeat = ints[1];
+        return 1;
+}
 
 __setup("atkbd_set=", atkbd_setup_set);
 __setup("atkbd_reset", atkbd_setup_reset);
+__setup("atkbd_softrepeat=", atkbd_setup_softrepeat);
 #endif
 
 int __init atkbd_init(void)

--HcAYCG3uE/tztfnV--
