Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWBVFUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWBVFUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 00:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWBVFUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 00:20:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:51131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751326AbWBVFUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 00:20:47 -0500
Date: Tue, 21 Feb 2006 21:09:31 -0800
From: Greg KH <gregkh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: david-b@pacbell.net, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060222050931.GA26947@suse.de>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060218000921.GA15894@suse.de> <20060219002133.GB11290@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219002133.GB11290@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 01:21:33AM +0100, Sam Ravnborg wrote:
> On Fri, Feb 17, 2006 at 04:09:21PM -0800, Greg KH wrote:
> > On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:
> > > Background:
> > > I have introduced a build-time check for section mismatch and it showed
> > > up a great number of warnings.
> > > Below is the result of the run on a 2.6.16-rc1 tree (which my kbuild
> > > tree is based upon) based on a 'make allmodconfig'
> 
> Greg - related to this I have thought a bit on __devinit versus __init.
> With HOTPLUG enabled __devinit becomes empty and thus violate any checks
> for illegal references to .init.text.

I _really_ hate __devinit.  Almost everyone who uses it gets it wrong
the first time (like pci hotplug drivers using it, which is just
pointless...)  Now that CONFIG_HOTPLUG is always enabled (well, it's a
lot harder to disable it now), hopefully when people get it wrong it
will not cause problems.

> Would it make sense to create a specific set of sections for __devinit
> and frinds so we could check that __devinit sections are not referenced from .text.
> This is another way to do the current __init checks but with HOTPLUG
> enabled and I like the result to be consistent with and without HOTPLUG
> enabled.

That's not a bad idea.

> Also I see __devinit being used in different ways. See sound/oss/mad16
> for instance.
> Only a few functions are marked __devinit nad I wonder if any should be
> marked __devinit at all in that file. But due to references to
> __initdata current checks discovered a potential bug here already today.

Like I said above, almost everyone uses it incorrectly.  I went through
the whole tree sometime late 2.5 and fixed up everything.  It's probably
time for another audit...

thanks,

greg k-h
