Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTFITbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTFITbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:31:36 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:23557 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264546AbTFITbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:31:34 -0400
Date: Mon, 9 Jun 2003 21:45:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, Jaroslav Kysela <perex@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: 2.5 kbuild: use of '-z muldefs' for LD?
Message-ID: <20030609194510.GA11830@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
	ALSA development <alsa-devel@alsa-project.org>,
	kbuild-devel@lists.sourceforge.net,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <Pine.LNX.4.44.0306091342400.1323-100000@pnote.perex-int.cz> <20030609130438.A6417@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609130438.A6417@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 01:04:38PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 09, 2003 at 01:56:59PM +0200, Jaroslav Kysela wrote:
> > one object file for more targets. Example:
> > 
> > ------
> > snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o ak4xxx.o
> > snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o ak4xxx.o
> > 
> > # Toplevel Module Dependency
> > obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o
> > obj-$(CONFIG_SND_ICE1724) += snd-ice1724.o
> > ------
> > 
> > The ak4xxx.o module is shared and has defined a few public functions.
> > Unfortunately, the default build-in.o rule fails when targets are 
> > requested to be included into the solid kernel because the public 
> > functions are duplicated in snd-ice1712.o and snd-ice17124.o.
> > 
> > I can instruct the ld compiler to ignore the multiple definitions using 
> > '-z muldefs':
> > 
> > EXTRA_LDFLAGS = -z muldefs
> > 
> > But it seems like a hack for me.
> > Does anybody have another idea to solve my problem?
> 
> Move ak4xxx.o out of the multi-obj rules.  Just declare a new helper-
> config option CONFIG_SND_AK4XXX that gets defined by all drivers
> using it and add
> 
> obj-$(CONFIG_SND_AK4XXX)	+= ak4xxx.o

Would it be worthwhile to resolve common functions from a library instead?
On request from Linus I made the lib-y change, and it is getting
a lot easier to create libraries.
So ak4xxx.o would be used to create lib.a in that particular directory.

A limitation would be that libaries would only be valid for current
directory - but that is OK for this situation.

On the other hand there should be very good reasons to clutter up the
build-system with this, so more users than sound is required.

Comments?
[Will there be problems with modules exporting symbols?]

	Sam
