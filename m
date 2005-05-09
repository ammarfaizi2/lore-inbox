Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVEIVOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVEIVOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVEIVOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:14:04 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:62156 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261528AbVEIVNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:13:55 -0400
Date: Mon, 9 May 2005 23:13:24 +0200
From: Per Svennerbrandt <per.svennerbrandt@lbi.se>
To: Per Liden <per@fukt.bth.se>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050509211323.GB5297@tsiryulnik>
Mail-Followup-To: Per Liden <per@fukt.bth.se>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Per Liden (per@fukt.bth.se) wrote:
> On Fri, 6 May 2005, Greg KH wrote:
> 
> [...]
> > Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> > USB hotplug program can be written with a simple one line shell script:
> > 	modprobe $MODALIAS
> 
> Nice, but why not just convert all this to a call to 
> request_module($MODALIAS)? Seems to me like the natural thing to do.

I actually have a pretty hackish proof-of-consept patch that does
basicly that, and have been running it on my systems for the past five
months or so, if anybody's interested.

Along with it I also have a patch witch exports the module aliases for
PCI and USB devices through sysfs. With it the "coldplugging" of a
system (module wise) can be reduced to pretty much:

#!/bin/sh

for DEV in /sys/bus/{pci,usb}/devices/*; do
	modprobe `cat $DEV/modalias`
done

(And I actually run exactly that on my laptop, and it works surpricingly
well. (Largly due to the fact that the usb-controller is always attached
below the pci-bus of course, but it really wouldn't take that much work 
to make it do the right thing even without relying on any specific 
ordering/topology))

With the above in place my system does all the module-loading that I
care about automaticly, and most importantly does so without relying
on an /etc/hotplug/ dir with everything and it's grandma in it (or at
least thousands of lines of shellscripting).

But since the request_modalias() thing seemed as such an obvious thing
to do I have been reluctant to submit it fearing that I must have missed
some fundamental flaw in it or you guys would have implemented it that 
way a long time ago? (at least since Rusty rewrote the module
loader). Was I wrong*?

Greg, Rusty, what do you think?

/ Per Svennerbrandt

* I also actually had my kernel add MODALIAS to the hotplug enviroment
long before Roman submited his patch doing this, even calling it MODALIAS
from the very beginning! :) So obviously I've been wrong before...
