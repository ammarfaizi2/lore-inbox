Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUHLLJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUHLLJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 07:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268514AbUHLLJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 07:09:35 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:58079 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268511AbUHLLJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 07:09:27 -0400
Date: Thu, 12 Aug 2004 12:07:29 +0100
From: Dave Jones <davej@redhat.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040812110729.GP17673@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Deepak Saxena <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com
References: <20040811224117.GA6450@plexity.net> <20040811231314.GA32106@redhat.com> <20040811234245.GA7721@plexity.net> <20040811235929.GB32468@redhat.com> <20040812024554.GA20792@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812024554.GA20792@plexity.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 07:45:54PM -0700, Deepak Saxena wrote:

 > If we can look at
 > what really needs to be exported as a separate object and what
 > can be determined by userspace via parsing of binary blob, that
 > size diference will probably shrink considerably. 

And if we decide not to do this, the size difference shrinks even
more considerably. People who don't give a rats ass about this stuff
aren't wasting memory for each sysfs node.

The only justification I've seen so far for this bloat is
"other subsystems have put their crap in sysfs, so I want to do the same".

 > >  > > /proc/cpuinfo has done well enough for us for quite a number of years
 > >  > > now, what makes it so urgent to kill it now that sysfs is the
 > >  > > virtual-fs-de-jour ?
 > >  > Consitency in userspace interface.
 > > 
 > > sorry, but I think that argument is total crap.  Any userspace tool needing
 > > this info will still need to support the /dev/cpu/ interfaces if they want to
 > > also run on 2.2 / 2.4 kernels.  Likewise, anything using /proc/cpuinfo.
 > > Ripping this out does nothing useful that I see other than cause headache
 > > for userspace by having yet another interface to support.
 > 
 > In my original email I specifically said that we cannot remove /proc/cpuinfo 
 > today b/c of application requirements, but this is something for down
 > the road.

Yes. And then when presented with the "but this is useless, because we already
have /dev/cpu" argument, you decided to deprecate that for no reason too,
in the name of 'consistency'.

This is madness.

This 'consistency' costs. As I already mentioned, an application that
runs on any kernel would now have to support an extra method of obtaining
the data it needs.  Then people wonder why userspace apps are bloating
up further and further each year. Then people wonder why installers
suddenly need an extra xMB of RAM to install the latest version of
a distro.

 > Nothing wrong with taking time. I never said we need to get rid of
 > stuff overnight. We can keep old interfaces around (see /proc/pci
 > for example) as long as it takes for core apps and kernel stuff
 > to switch over.

There was a 'joke' a while ago about some corporations handing out
bonuses to its engineers each time a patch was accepted that removed
a user of the big kernel lock.  These days I wonder if the same
analogy is holding true for systfs patches.

		Dave

