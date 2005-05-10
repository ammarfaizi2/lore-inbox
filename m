Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVEJWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEJWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVEJWR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:17:57 -0400
Received: from 1-1-2-5a.f.sth.bostream.se ([81.26.255.57]:36303 "EHLO
	1-1-2-5a.f.sth.bostream.se") by vger.kernel.org with ESMTP
	id S261841AbVEJWR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:17:26 -0400
Date: Wed, 11 May 2005 00:17:12 +0200 (CEST)
From: Per Liden <per@fukt.bth.se>
X-X-Sender: per@1-1-2-5a.f.sth.bostream.se
To: Per Svennerbrandt <per.svennerbrandt@lbi.se>
cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
In-Reply-To: <20050509211323.GB5297@tsiryulnik>
Message-ID: <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
References: <20050506212227.GA24066@kroah.com>
 <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
 <20050509211323.GB5297@tsiryulnik>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Per Svennerbrandt wrote:

> * Per Liden (per@fukt.bth.se) wrote:
> > On Fri, 6 May 2005, Greg KH wrote:
> > 
> > [...]
> > > Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> > > USB hotplug program can be written with a simple one line shell script:
> > > 	modprobe $MODALIAS
> > 
> > Nice, but why not just convert all this to a call to 
> > request_module($MODALIAS)? Seems to me like the natural thing to do.
> 
> I actually have a pretty hackish proof-of-consept patch that does
> basicly that, and have been running it on my systems for the past five
> months or so, if anybody's interested.

Ah! Please post the patches.

> Along with it I also have a patch witch exports the module aliases for
> PCI and USB devices through sysfs. With it the "coldplugging" of a
> system (module wise) can be reduced to pretty much:
> 
> #!/bin/sh
> 
> for DEV in /sys/bus/{pci,usb}/devices/*; do
> 	modprobe `cat $DEV/modalias`
> done

Nice! This is really what coldplugging _should_ look like. Hmm, maybe 
even coldplug the system by request_module()'ing those as well at some 
stage?

> (And I actually run exactly that on my laptop, and it works surpricingly
> well. (Largly due to the fact that the usb-controller is always attached
> below the pci-bus of course, but it really wouldn't take that much work 
> to make it do the right thing even without relying on any specific 
> ordering/topology))
> 
> With the above in place my system does all the module-loading that I
> care about automaticly, and most importantly does so without relying
> on an /etc/hotplug/ dir with everything and it's grandma in it (or at
> least thousands of lines of shellscripting).

This is exactly what I'm looking for as well.

> But since the request_modalias() thing seemed as such an obvious thing
> to do I have been reluctant to submit it fearing that I must have missed
> some fundamental flaw in it or you guys would have implemented it that 
> way a long time ago? (at least since Rusty rewrote the module
> loader). Was I wrong*?
> 
> Greg, Rusty, what do you think?

I'd like to get a better understanding of that as well. Why invent a 
second on demand module loader when we have kmod? The current approach 
feels like a step back to something very similar to the old kerneld.

/Per L
