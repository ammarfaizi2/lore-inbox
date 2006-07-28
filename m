Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161311AbWG1V1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWG1V1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWG1V1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:27:05 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:58059 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161311AbWG1V1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:27:02 -0400
Date: Fri, 28 Jul 2006 23:26:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
Message-ID: <20060728212643.GA32455@mars.ravnborg.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607282045.05292.ak@suse.de> <1154112511.6416.46.camel@laptopd505.fenrus.org> <200607282100.01783.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607282100.01783.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 09:00:01PM +0200, Andi Kleen wrote:
> On Friday 28 July 2006 20:48, Arjan van de Ven wrote:
> > On Fri, 2006-07-28 at 20:45 +0200, Andi Kleen wrote:
> > > > +ifdef CONFIG_CC_STACKPROTECTOR
> > > > +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> > > > +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
> > >
> > > Why can't you just use the normal call cc-option for this?
> >
> > this requires gcc 4.2; cc-option is not useful for that.
> 
> The CC option thing is also very ugly.
The check is executed once pr. kernel compile - or at least once pr.
line. The reson to use cc-ifversion is that we need to check for a
specific gcc version and not just support for a specific argument type.

That said - checking for a version is not as reliable as checking if a
certain feature is really supported but Arjan suggested testing for
version >= 4.2 should do it.
Also we do not have any helpers in kbuild to do so -that could be worked
out so we could do something almost as elegant as 
$(call cc-ifversion ...)

	Sam
