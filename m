Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWGaX6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWGaX6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWGaX6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:58:55 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:32431 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751497AbWGaX6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:58:36 -0400
From: David Brownell <david-b@pacbell.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Date: Mon, 31 Jul 2006 16:55:42 -0700
User-Agent: KMail/1.7.1
Cc: Jean Delvare <khali@linux-fr.org>, Komal Shah <komal_shah802003@yahoo.com>,
       akpm@osdl.org, gregkh@suse.de, i2c@lm-sensors.org, imre.deak@nokia.com,
       juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org,
       r-woodruff2@ti.com, tony@atomide.com
References: <1154066134.13520.267064606@webmail.messagingengine.com> <200607310941.01340.david-b@pacbell.net> <20060731191001.GA10489@flint.arm.linux.org.uk>
In-Reply-To: <20060731191001.GA10489@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607311655.43524.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 12:10 pm, Russell King wrote:
> On Mon, Jul 31, 2006 at 09:41:00AM -0700, David Brownell wrote:
> > On Monday 31 July 2006 9:13 am, Jean Delvare wrote:
> > > Hi David,
> > > 
> > > > And I **really** hope this gets merged into 2.6.18 since virtually
> > > > no OMAP board is very usable without it.  I2C is one of the main
> > > > missing pieces(*) ... can whoever's managing I2C merges please
> > > > expedite this?
> 
> Slightly off-topic, and probably not your area, but it would probably
> help your case if omap were better looked after in mainline. 

Actually that _is_ part of my case.  It can't be looked after in any
reasonable way until the I2C driver gets merged, because significant
chunks of the OMAP driver stack require I2C.  (And notably for me,
USB always requires I2C to handle VBUS switches ...)

So for example once the OMAP I2C gets merged, then it'll finallly
become practical for folk to try _using_ mainline kernels.  Which
is a prerequisite for getting the bugs there fixed with any level
of promptness, since they can't be fixed until they're noticed.


> Most OMAP 
> platforms build fine, except for one long standing one - the H2 1610
> defconfig, which hasn't built since 2.6.17-git11.

Yet oddly enough, that's the only OMAP defconfig present.  :( 

Once I2C gets merged, the OSK defconfig could be merged too; and
that's a much handier board to work with and test.  H2 and OSK use
basically the same OMAP chip (5912 ~= 1610b), but 5912 doesn't need
NDAs; and the OSK board is is 10x smaller in size and price, plus
it's available on the open market.


> So, rather than shoveling new stuff in there, can the maintainence of
> the stuff already merged please be improved.
> 
> Build results vs kernel version for H2 1610:
> 
> http://armlinux.simtec.co.uk/kautobuild/omap_h2_1610_defconfig.html

You'll observe that I recently posted four build fixes (tps65010,
ohci-omap, omap-rng, smc91x) ... all of which would affect H2... the
fifth build fix will go to your armlinux patch database soon, it
addresses the fatal error in that build log.  I've already submitted
patches for the three Kconfig complaints.  (By the way, those build
logs could become more informative by using "make -k" ...)

Plus H2 is another of the OMAP platforms that can't be fully
initialized without using I2C.  :)

- Dave



