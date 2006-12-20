Return-Path: <linux-kernel-owner+w=401wt.eu-S964919AbWLTICJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWLTICJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 03:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbWLTICJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 03:02:09 -0500
Received: from mx1.suse.de ([195.135.220.2]:53027 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbWLTICI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 03:02:08 -0500
Date: Wed, 20 Dec 2006 00:01:33 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jean Delvare <khali@linux-fr.org>,
       Olivier Galibert <galibert@pobox.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare
Message-ID: <20061220080133.GA4325@kroah.com>
References: <1165694351.1103.133.camel@localhost.localdomain> <20061209123817.f0117ad6.akpm@osdl.org> <20061209214453.GA69320@dspnet.fr.eu.org> <20061209135829.86038f32.akpm@osdl.org> <20061209223418.GA76069@dspnet.fr.eu.org> <20061209145303.3d5fe141.akpm@osdl.org> <1165712131.1103.166.camel@localhost.localdomain> <20061215154751.86a2dbdd.khali@linux-fr.org> <1166213773.31351.96.camel@localhost.localdomain> <20061215123103.adfbd78b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215123103.adfbd78b.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 12:31:03PM -0800, Andrew Morton wrote:
> On Sat, 16 Dec 2006 07:16:13 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > > Beware that sysfs_remove_bin_file() will complain loudly if you later
> > > attempt to delete that file that was never created.
> > 
> > That's another problem... what is a driver that creates 15 files
> > supposed to do ? Have 15 booleans to remember which files where
> > successfully created and then test all of them on cleanup ? That sounds
> > like even more bloat to me...
> 
> That's the sort of thing which should be done inside sysfs_create_group()
> and sysfs_remove_group().

sysfs_create_group() and remove_group() handles this just fine right
now.  Or it should, if not, please let me know and I'll fix it.

As for the bin_file stuff, those are very rare.  And I'll gladly take
patches that keep bad things from happening if you try to remove a file
that isn't there.

thanks,

greg k-h
