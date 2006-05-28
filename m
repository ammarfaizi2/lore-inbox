Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWE1TXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWE1TXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 15:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWE1TXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 15:23:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29968 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750815AbWE1TXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 15:23:06 -0400
Date: Sun, 28 May 2006 21:10:45 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060528191045.GY11191@w.ods.org>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148839964.3074.52.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 08:12:44PM +0200, Arjan van de Ven wrote:
> On Sun, 2006-05-28 at 13:52 -0400, Lee Revell wrote:
> > On Sun, 2006-05-28 at 19:03 +0200, Arjan van de Ven wrote:
> > > On Sun, 2006-05-28 at 15:03 +0200, Heiko Carstens wrote:
> > > > > > > How does one check the existence of the kernel source RPM (or deb) on
> > > > > > > every single distribution?.
> > > > > > > 
> > > > > > > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> > > > > > > SuSE, Mandrake and CentOS - how about other RPM based distros? How
> > > > > > > about debian based distros?. There doesn't seem to be a a single
> > > > > > > conherent naming scheme.  
> > > > > > 
> > > > > > I'd really like to see a distro-agnostic way to retrieve the kernel
> > > > > > configuration.  /proc/config.gz has existed for soem time but many
> > > > > > distros inexplicably don't enable it.
> > > > > 
> > > > > /boot/config-`uname -r`
> > > > 
> > > > What's the reason for distros to disable /proc/config.gz?
> > > 
> > > what would be a reason to ENable it???
> > > it's double functionality that does take memory away...
> > > 
> > 
> > It sounds like there is in fact no distro agnostic way to retrieve the
> > kernel config 
> 
> /boot/config-`uname -r` goes a long way, and yes I'm ignoring the "but
> users CAN clobber the file if they use enough violence against their
> packaging system" argument entirely. That's just a bogus one.
> 
> Also... why would there really be a need for such a way? Not for
> building anything for sure.... it's for the human. And the human seems
> to just find it already (and again the boot file works well in practice
> it seems)

Well, /boot/config-`uname -r` would not work right here, as well as on
a number of people's systems that I know, simply because a solution to
avoid the awful mess in /boot is to mkdir /boot/$(uname -r) and put
your System.map, .config and bzImage there (BTW, I also put modules
there since my /lib/modules is a symlink to /boot). This way, there
is only *ONE* rm -rf to do to remove an old unused kernel. So in this
case, it would be /boot/$(uname -r)/.config.

On another subject, I find /proc/config.gz useful when debugging kernels
because this is the only *safe* way to know what was put in a given kernel
that I have booted in the middle of others. However, I agree that this
does not bring much usefulness on distro kernels.

Cheers,
Willy

