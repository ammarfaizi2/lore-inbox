Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbTGBOGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTGBOGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:06:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42950 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264993AbTGBOGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:06:19 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: dm-devel@sistina.com, Joe Thornber <thornber@sistina.com>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Date: Wed, 2 Jul 2003 09:15:10 -0500
User-Agent: KMail/1.5
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <200307011505.07184.kevcorry@us.ibm.com> <20030702085951.GB410@fib011235813.fsnet.co.uk>
In-Reply-To: <20030702085951.GB410@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307020915.10573.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 03:59, Joe Thornber wrote:
> On Tue, Jul 01, 2003 at 03:05:07PM -0500, Kevin Corry wrote:
> > > +static int check_name(const char *name)
> > > +{
> > > +	if (strchr(name, '/')) {
> > > +		DMWARN("invalid device name");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> >
> > Can't we allow slashes in device names? I thought we discussed this
> > before (http://marc.theaimsgroup.com/?t=104628092700011&r=1&w=2). Any
> > reason for the change?
>
> I think I made the wrong decision before.  Still thinking about it though.

Well, what are your current thoughts?

I guess the way I see it is that this name is simply a way for user-space to 
identify a device to the driver, and it seems kind of unnecessary for the 
driver to put restrictions on that name.

The only reason I can really think of to restrict the contents of this name is 
due to using the name for devfs. But devfs doesn't seem to mind dealing with 
names with embedded slashes (I always run with devfs enabled, and I've never 
seen it complain).

On a side note, looking through the devfs code reveals a potential error. In 
DM, names can be 127 characters. But devfs_mk_bdev() (in fs/devfs/base.c) 
will only accept names up to 63 characters. If it gets a name longer than 
that, it just returns an error, which DM will ignore. This isn't a fatal 
error by any means, but if any user-space tools rely on those devfs devices 
being created, there may be cases where the tools won't work correctly.

> > Does this imply that if the dm_swap_table() call fails, then the
> > "inactive" mapping is automatically deleted?
>
> Yes, that is the behaviour ATM.  Would you rather it didn't ?

Well...I can't say that it makes much difference to me either way at the 
moment. :) I just wanted to clarify the behavior, since it wasn't explicitly 
stated anywhere.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

