Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWHOWl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWHOWl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWHOWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:41:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:43895 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750757AbWHOWlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:41:25 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,129,1154934000"; 
   d="scan'208"; a="116758447:sNHT11483100363"
Date: Tue, 15 Aug 2006 15:41:08 -0700
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: Bill Nottingham <notting@redhat.com>
cc: Stephen Hemminger <shemminger@osdl.org>,
       "Williams, Mitch A" <mitch.a.williams@intel.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
In-Reply-To: <20060815214914.GA5307@nostromo.devel.redhat.com>
Message-ID: <Pine.CYG.4.58.0608151532070.2316@mawilli1-desk2.amr.corp.intel.com>
References: <20060815194856.GA3869@nostromo.devel.redhat.com>
 <Pine.CYG.4.58.0608151331220.3272@mawilli1-desk2.amr.corp.intel.com>
 <20060815204555.GB4434@nostromo.devel.redhat.com> <20060815140249.15472a82@dxpl.pdx.osdl.net>
 <20060815214914.GA5307@nostromo.devel.redhat.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006, Bill Nottingham wrote:
>
> Stephen Hemminger (shemminger@osdl.org) said:
> > > They're certainly allowed, and the sysfs directory structure, files,
> > > etc. handle it ok. Userspace tends to break in a variety of ways.
> > >
> > > I believe the only invalid character in an interface name is '/'.
> > >
> >
> > The names "." and ".." are also verboten.
>
> Right. Well, I suspect they're verboten-because-some-code-breaks-making-the-directory.
>
> > Names with : in them are for IP aliases.
>

So can we use
	sscanf(buffer, " %[^\n]", command);
instead?  This should allow for whitespace in the filename.  Bad interface
names will be caught by the call to dev_valid_name().

(I think I'm reading the man page correctly.)

This could have the effect of making the parser way more finicky, though,
since we would allow trailing whitespace.  Technically I suppose it's
legal, but it's sure hard to see on the screen.

Anybody have a better solution?

-Mitch
