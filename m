Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWBSAWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWBSAWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWBSAWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:22:19 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:46094 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932368AbWBSAWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:22:18 -0500
Date: Sun, 19 Feb 2006 01:21:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <gregkh@suse.de>
Cc: david-b@pacbell.net, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060219002133.GB11290@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060218000921.GA15894@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218000921.GA15894@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:09:21PM -0800, Greg KH wrote:
> On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:
> > Background:
> > I have introduced a build-time check for section mismatch and it showed
> > up a great number of warnings.
> > Below is the result of the run on a 2.6.16-rc1 tree (which my kbuild
> > tree is based upon) based on a 'make allmodconfig'

Greg - related to this I have thought a bit on __devinit versus __init.
With HOTPLUG enabled __devinit becomes empty and thus violate any checks
for illegal references to .init.text.

Would it make sense to create a specific set of sections for __devinit
and frinds so we could check that __devinit sections are not referenced from .text.
This is another way to do the current __init checks but with HOTPLUG
enabled and I like the result to be consistent with and without HOTPLUG
enabled.

Also I see __devinit being used in different ways. See sound/oss/mad16
for instance.
Only a few functions are marked __devinit nad I wonder if any should be
marked __devinit at all in that file. But due to references to
__initdata current checks discovered a potential bug here already today.

	Sam
