Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266306AbUHTF5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266306AbUHTF5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 01:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUHTF5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 01:57:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:41452 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266306AbUHTF5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 01:57:43 -0400
Date: Fri, 20 Aug 2004 07:57:41 +0200
From: Olaf Hering <olh@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, Dave Boutcher <boutcher@us.ibm.com>,
       linuxppc64-dev@lists.linuxppc.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module.viomap support for ppc64
Message-ID: <20040820055741.GA16519@suse.de>
References: <20040812173751.GA30564@suse.de> <1092339278.19137.8.camel@localhost> <1092354195.25196.11.camel@bach> <20040813094040.GA1769@suse.de> <1092404570.29604.5.camel@bach> <20040819212824.GA13204@suse.de> <1092973671.28849.243.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092973671.28849.243.camel@bach>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Aug 20, Rusty Russell wrote:

> Current implementation of aliases is to load one at random: multiple
> alias resolution is undefined because noone knew what we should do (load
> them all?  Load until one succeeds?).  But note that that the base
> config file overrides anything extracted from the modules themselves, so
> users/distributions can always specify an exact match.

How is the blacklist stuff supposed to work then? It must be possible
to map an alias entry to a list of modules, and check if any of them is
blacklisted. Then just 'for i in $DRIVERS ; do modprobe $i ; done'.

> > Is there such functionality for the modules.alias file in
> > module-init-tools? I played around with modprobe -n, but could not
> > figure it out. Unfortunately, some hardware has more than one driver.
> > bcm5700/tg3, eepro100/e100 and maybe more.
> 
> OK, I think the difference here is that I feel modprobe should resolve
> it.  What's the right answer?  Do we need a new "unalias" config cmd
> which does the blacklist, or is the current positive method better?  How
> do you currently decide?

modprobe or some other tool can certainly resolve it, but something has
to make a decision based on a blacklist if a certain module can be
loaded.
Look at /etc/hotplug/pci.agent how it currently done, it parses the
modules.pcimap, fills $DRIVERS and passes that variable to the generic
modprobe function from hotplug.functions. It reads
/etc/hotplug/blacklist to decide if any of the modules listed in DRIVERS
must be skipped.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
