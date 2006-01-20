Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWATX1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWATX1I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWATX1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:27:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:53637
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932139AbWATX1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:27:06 -0500
Date: Fri, 20 Jan 2006 15:27:03 -0800
From: Greg KH <greg@kroah.com>
To: Michael Loftis <mloftis@wgops.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120232703.GB20949@kroah.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr> <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com> <20060120194331.GA8704@kroah.com> <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 01:56:12PM -0700, Michael Loftis wrote:
> 
> 
> --On January 20, 2006 11:43:31 AM -0800 Greg KH <greg@kroah.com> wrote:
> 
> >On Fri, Jan 20, 2006 at 10:14:15AM -0700, Michael Loftis wrote:
> >>The problem here is I'm spending a lot of my time lately fixing things
> >>that  shouldn't need fixing.  Things that are/were developed against
> >>what was  supposed to be a stable major version and has been turned into
> >>a  development version.
> >
> >What specifically are you "fixing"?
> 
> At this point I'm looking at bugs in the aic7xxx driver, it mostly works in 
> 2.6.8, occasionally locking up my tape subsystem, it's apparently fixed in 
> 2.6.15 or 2.6.15.1, I need to look closer into that, and backport it 
> because of the devfs issue I don't think I can take 2.6.15/2.6.15.1 whole 
> hog.

devfs is long dead and gone.  It's going to be much easier for you to
probably just change your userspace config to handle this.

If you need any help doing this, please ask on the linux-hotplug-devel
mailing list, where lots of people can help you out.

Or, just add the CONFIG_DEVFS config option to your .config, and build
devfs into the 2.6.15 release.  The code is still there...

> As far as fixing there are modules that have been developped to run various 
> embedded peripherals that must be reworked to use the newer kernel 
> versions, which wouldn't be a problem if there weren't various other fixes 
> that were needed which means moving up point revs.  Most of these other 
> bugs are external to my work, but they affect my work.  The modules are 
> completely isolated from the rest of the kernel though and they're for very 
> particular hardware for different clients.

There's nothing we can do about out-of-the-tree kernel versions, see
Documentation/stable_api_nonsense.txt about why you should get those
modules into the main kernel tree.

And before you say, "but they are only for some very odd and not popular
devices, no one would want them in the kernel tree!", remember that we
have whole arches that are only run by about 2 users.  I know
specifically about a few drivers that only work on 1 device in the whole
world.  So this isn't a good excuse :)

Your other issues sound like they will be fixed with the latest kernel
version, if not, please let us know.

> I think I have more kernel bugs and can go on, but I'll just be told 
> 'upgrade to 2.6.15' which is not an option in many cases if these are 
> indeed development releases, if only 'politically', but there are often 
> real costs involved.

Then what do you expect us to do?  And what are those costs?

> And with nowhere to put patches that end up in maintenance releases
> we're forced to maintain our own private forks, and likely, because of
> the GPL, also publish these forks and incur all the costs associated
> with that directly, and hope they don't become popular/wanted outside
> of the customer base they're intended for, or skirt the GPL, and only
> allow customers access to this stuff.

I hear sf.net hosts patches for free :)  I know of a specific big distro
vendor that likes to burry their patches there to apease the letter of
the GPL, and make it hard for others to figure out where the code is...

thanks,

greg k-h
