Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbTFEM2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbTFEM2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:28:47 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:38974 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264653AbTFEM2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:28:46 -0400
Date: Thu, 05 Jun 2003 08:36:38 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: Re: /proc/bus/pci
In-reply-to: <1054814759.22103.6114.camel@cube>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       bcollins@debian.org, wli@holomorphy.com, tom_gall@vnet.ibm.com,
       anton@samba.org
Message-id: <1054816598.22103.6151.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0306042117440.2761-100000@home.transmeta.com>
 <1054814759.22103.6114.camel@cube>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 08:05, Albert Cahalan wrote:
> On Thu, 2003-06-05 at 00:23, Linus Torvalds wrote:
> > On Wed, 4 Jun 2003, Albert Cahalan wrote:
> > >
> > > I notice that /proc/bus/pci doesn't offer a sane
> > > interface for multiple PCI domains and choice of BAR.
> > > What do people think of this?
> > > 
> > > bus/pci/00/00.0 -> ../hose0/bus0/dev0/fn0/config-space
> > 
> > Why do we have that stupid "hose" name? Only because of strange alpha 
> > naming, or did somebody else also use that incredibly silly name?
> > 
> > Please talk about "domains", at least it makes some sense as a name.
> 
> "hose" does sound pretty crazy, but...
> 
> a. "domain" is way overused in OSes and programming
> b. "hose" is short
> c. with old names like "d4", "hose" is better for tab-completion
> 
> I'm sure somebody could name a dozen things called "domain".
> 
> > I'm also hoping that /proc/bus will eventually go away, so I don't see a 
> > major problem with not understanding multiple domains at that level.
> > 
> > On a /sys/bus/xxx level we actually should already be able to handle 
> > multiple domains, but the naming is broken. However, in /sys we should be 
> > able to nicely handling non-zero domains by just extending the name space 
> > a bit.
> 
> Does this mean you'd like to see per-BAR kobject stuff?
> If I'm not mistaken, that is required for sysfs to work.
> 
> So sysfs then has:
> 
> devices/pci2/02:0b.0 -> ../hose0/bus2/dev11/fn0
> devices/hose0/bus2/dev11/fn0/config-space
> devices/hose0/bus2/dev11/fn0/bar0
> devices/hose0/bus2/dev11/fn0/bar1
> devices/hose0/bus2/dev11/fn0/bar2
> devices/hose0/bus2/dev11/fn0/class
> devices/hose0/bus2/dev11/fn0/power
> devices/hose0/bus2/dev11/fn0/subsystem_vendor
> devices/hose0/bus2/dev11/fn0/and-so-on
> 
> To make this clear, mmap() on bar0 would get you
> a mapping of that BAR.

Some of the IBMers use "phb" instead of "hose" or "domain".
It's Primary Host Bridge, which can only be confused
with Pointy-Haired Boss AFAIK.


