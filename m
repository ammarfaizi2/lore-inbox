Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWDSPcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDSPcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWDSPcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:32:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37090 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750857AbWDSPcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:32:12 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Jon Masters" <jonathan@jonmasters.org>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Date: Wed, 19 Apr 2006 17:32:08 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060418234156.GA28346@apogee.jonmasters.org> <200604191107.10562.duncan.sands@math.u-psud.fr> <35fb2e590604190541v714d3604w544a83876e5db14a@mail.gmail.com>
In-Reply-To: <35fb2e590604190541v714d3604w544a83876e5db14a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191732.08640.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I haven't really understood what problem this solves.  Is this just a
> > standardised form of documentation, or are you imagining that an automatic
> > tool will use this to auto include a minimal set of firmware files in an
> > initrd?
> 
> I'm imagining that the resultant modinfo output can be used by a tool
> for anyone to package up the correct firmware to go with a given
> driver.

If a tool is to do the packaging, then this means that the firmware must
already be present on the machine, for example in /lib/firmware.  Logically
speaking, that means the role of any tool is to select a subset of the files
in /lib/firmware, for example a minimal set for inclusion in an initrd.  After
all, it can't add new files that don't exist on the machine, since where would
it get them from?  (I suppose it could download them from "firmware central").
Is there any use for such a tool, besides creating small initrds?  How big an
issue is that?  Is there really any reason not to simply throw everything in
/lib/firmware into any initrd that is created?  But perhaps you are thinking of
the suppliers of a distribution who have a gazillion firmware files that they've
collected over the years, some of which are too old and some of which are too
recent for the drivers that will be shipped; and the tool is to select the subset
which is relevant for the shipped driver versions?  i.e. the firmware selection
process is not done on each end user's machine, but by the people preparing the
distribution.

> Right now, there's no way to do that - i.e. we've gone 
> backwards from a standpoint of coupling a kernel with firmware. I
> completely understand why firmware doesn't really belong in the
> kernel, so let's add this :-)

I guess a big difference between the speedtouch and the kinds of drivers
you seem to be thinking of, is that in your case there is a fairly tight
coupling between firmware and driver versions: a given driver version will
only work with a certain version of the firmware and vice-versa.  In the case
of the speedtouch, we have no control over (and not much knowledge about)
which firmware gets given to people along with their modems, so there is really
no coupling at all between firmware versions and driver versions.

> > I'm thinking of something like this: (1) redhat (or whoever) ships
> > firmware files for every driver under the sun in /lib/firmware; (2) redhat
> > wants to allow users to have a customized initrd with only essential drivers;
> > (3) the tool goes through the list of essential drivers, looks up the firmware
> > string via MODULE_FIRMWARE, finds the file in /lib/firmware, and includes it
> > in the initrd.
> 
> That kind of thing. It's not just Red Hat who benefit - anyone who
> wants to package up a kernel and do something with it will want to
> know about firmware they might need.

For this they could just read the documentation.  They'll need to anyway
just to find out where they are supposed to get the firmware from.

> Including everything in 
> /lib/firmware "just in case" is as ugly as having userspace tools with
> duplicated logic that need to understand about the internals of a
> driver module.

Don't distributions need to ship vast quantities of firmware in /lib/firmware
anyway, I mean firmware for every driver in the kernel, since they don't know
what hardware the end user may have?  So I guess you are talking about individual
users who compile their own kernels here.


Ciao,

D.

