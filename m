Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUHTDtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUHTDtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 23:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUHTDtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 23:49:09 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:18608 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S266427AbUHTDtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 23:49:03 -0400
Subject: Re: module.viomap support for ppc64
From: Rusty Russell <rusty@rustcorp.com.au>
To: Olaf Hering <olh@suse.de>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, Dave Boutcher <boutcher@us.ibm.com>,
       linuxppc64-dev@lists.linuxppc.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040819212824.GA13204@suse.de>
References: <20040812173751.GA30564@suse.de>
	 <1092339278.19137.8.camel@localhost> <1092354195.25196.11.camel@bach>
	 <20040813094040.GA1769@suse.de> <1092404570.29604.5.camel@bach>
	 <20040819212824.GA13204@suse.de>
Content-Type: text/plain
Message-Id: <1092973671.28849.243.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 13:47:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 07:28, Olaf Hering wrote:
>  On Fri, Aug 13, Rusty Russell wrote:
> 
> > On Fri, 2004-08-13 at 19:40, Olaf Hering wrote:
> > >  On Fri, Aug 13, Rusty Russell wrote:
> > > 
> > > > 2) Please modify scripts/mod/file2alias.c in the kernel source, not the
> > > > module tools.  The modules.XXXmap files are deprecated: device tables
> > > > are supposed to be converted to aliases in the build process, and that
> > > > is how userspace tools like hotplug are to find them.
> > > 
> > > I found no user of the modules.alias file. Hotplug still uses the map
> > > files. Parsing one big file will not improve performance, but thats a
> > > different story.
> > 
> > You don't use the modules.alias file.  You simply "modprobe vio:xyz^abc"
> > and modprobe reads modules.alias if necessary (the user can also insert
> > aliases in the modprobe.conf file, for example).  Note that fnmatch is
> > used, so you can actually use ? and * in your generated aliases.
> 
> But that complicates the parser. Current the hotplug agent script reads
> the simple modules.foomap and generates a list of possible drivers. Then
> it looks into the blacklist file to see if one of the possible modules
> should not be loaded, and skips this module.

Complicates?   Leave it to modprobe.  Don't read any files.  Really.

Current implementation of aliases is to load one at random: multiple
alias resolution is undefined because noone knew what we should do (load
them all?  Load until one succeeds?).  But note that that the base
config file overrides anything extracted from the modules themselves, so
users/distributions can always specify an exact match.

> Is there such functionality for the modules.alias file in
> module-init-tools? I played around with modprobe -n, but could not
> figure it out. Unfortunately, some hardware has more than one driver.
> bcm5700/tg3, eepro100/e100 and maybe more.

OK, I think the difference here is that I feel modprobe should resolve
it.  What's the right answer?  Do we need a new "unalias" config cmd
which does the blacklist, or is the current positive method better?  How
do you currently decide?

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

