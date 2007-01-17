Return-Path: <linux-kernel-owner+w=401wt.eu-S932633AbXAQSsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbXAQSsU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 13:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbXAQSsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 13:48:20 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:46868 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633AbXAQSsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 13:48:19 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 17 Jan 2007 13:42:15 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "obsolete" versus "deprecated", and a new config option?
In-Reply-To: <45AE6759.70108@tmr.com>
Message-ID: <Pine.LNX.4.64.0701171333270.2800@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
 <45AE6759.70108@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Bill Davidsen wrote:

> Robert P. J. Day wrote:
> >   a couple random thoughts on the notion of obsolescence and
> > deprecation.
>
> 	[...horrible example deleted...]
>
> >   so is that ioctl obsolete or deprecated?  those aren't the same
> > things, a good distinction being drawn here by someone discussing
> > devfs:
> >
> > http://kerneltrap.org/node/1893
> >
> > "Devfs is deprecated.  This means it's still available but you
> > should consider moving to other options when available.  Obsolete
> > means it shouldn't be used.  Some 2.6 docs have confused these two
> > terms WRT devfs."
> >
> >   yes, and that confusion continues to this day, when a single
> > feature is described as both deprecated and obsolete.  not good.
> > (also, i'm guessing that anything that's "obsolete" might deserve
> > a default of "n" rather than "y", but that's just me.  :-)
>
> Agree on that. I would hope "obsolete" means there's a newer way
> which should provide the functionality (** help should say where
> that is **) while depreciated should mean "we decided this was a bad
> solution" or something like that.

in simpler terms, "deprecated" (note correct spelling :-) should mean
"it's still available and you can use it but you should seriously
think of moving up soon 'cuz this is going to disappear some day,"
while "obsolete" should mean, "it's dead, jim."

> >   in any event, what about introducing a new config variable,
> > OBSOLETE, under "Code maturity level options"?  this would seem to
> > be a quick and dirty way to prune anything that is *supposed* to
> > be obsolete from the build, to make sure you're not picking up
> > dead code by accident.
>
> If you're doing that, why not four variables, for incomplete,
> experimental, obsolete and depreciated? Unfortunately doing any more
> detailed nomenclature would be a LOT of work!

i wouldn't go that far.  using deprecated code is still technically
fine, but using obsolete code should be something that raises a red
flag of some kind.  i would just somehow mark the OBSOLETE stuff.  in
fact, some kernel config options already do something like this, such
as in drivers/mtd/chips/Kconfig:

config MTD_OBSOLETE_CHIPS
        depends on MTD
        bool "Older (theoretically obsoleted now) drivers for non-CFI chips"
        help
          ... yadda yadda yadda ...

config MTD_AMDSTD
        tristate "AMD compatible flash chip support (non-CFI)"
        depends on MTD && MTD_OBSOLETE_CHIPS && BROKEN
        ...

and there's plenty of places in the Kconfig files that label features
as obsolete.  i just want the ability to switch all that stuff off
with one mouse click and see what happens.

rday
