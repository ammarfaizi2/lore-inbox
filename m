Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423333AbWJZMAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423333AbWJZMAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423305AbWJZMAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:00:09 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62634 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1423246AbWJZMAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:00:07 -0400
Date: Thu, 26 Oct 2006 14:00:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Dick Streefland <dick.streefland@altium.nl>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sam@ravnborg.org
Subject: Re: What about make mergeconfig ?
In-Reply-To: <Pine.LNX.4.61.0610261322120.29875@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0610261357080.1555@pademelon.sonytel.be>
References: <3d6d.453f3a0f.92d2c@altium.nl> <1161755164.22582.60.camel@localhost.localdomain>
 <3d6d.453f3a0f.92d2c@altium.nl> <Pine.LNX.4.61.0610251336580.23137@yvahk01.tjqt.qr>
 <31ed.453f5399.96651@altium.nl> <Pine.LNX.4.61.0610261000210.29875@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0610261102520.1555@pademelon.sonytel.be>
 <Pine.LNX.4.61.0610261322120.29875@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, Jan Engelhardt wrote:
> >> >Or you can use the following hack:
> >> >
> >> >  (sort .config other.config; echo set) | sh | grep ^CONFIG_ > new.config
> >> 
> >> That does not properly deal with "# CONFIG_XYZ is not set" lines in 
> >> other.config.
> >
> >What about RCS merge?
> 
> I take it we do not want to depend on too many tools (remember the 
> kconfig implementation language debate).

If you have CVS installed, you have RCS merge.

> >merge -p other.config .config.old .config > other.config.new
> 
> This also does not seem conflict-safe.

Indeed, you can still have conflicts, which you have to resolve manually.

But it depends on what you want to achieve: do you want to set each config
option in the destination config to max(config1.option, config2.option), or do
you want to apply the recent changes for one config (which may include
disabling options) to another config?

For the latter, merge should work fine.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
