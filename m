Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWB0Ir1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWB0Ir1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWB0Ir1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:47:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55515 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932310AbWB0Ir1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:47:27 -0500
Subject: Re: GFS2 Filesystem [15/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060222185400.GD2633@ucw.cz>
References: <1140793662.6400.738.camel@quoit.chygwyn.com>
	 <20060222185400.GD2633@ucw.cz>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 27 Feb 2006 08:52:36 +0000
Message-Id: <1141030356.6400.786.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-02-22 at 18:54 +0000, Pavel Machek wrote:
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <linux/fs.h>
> > +#include <linux/smp_lock.h>
> > +
> > +#include "../../lm_interface.h"
> 
> ugly...
> 
Agreed (see below)

> > +{
> > +	char *c;
> > +	unsigned int jid;
> > +	struct nolock_lockspace *nl;
> > +
> > +	/* If there is a "jid=" in the hostdata, return that jid.
> > +	   Otherwise, return zero. */
> 
> useful comment of the year 2006....
> 
> > +	c = strstr(host_data, "jid=");
> > +	if (!c)
> > +		jid = 0;
> > +	else {
> > +		c += 4;
> > +		sscanf(c, "%u", &jid);
> > +	}
> > +
> 
> ...
> > +
> > +static int nolock_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
> > +			   lm_lock_t **lockp)
> > +{
> > +	*lockp = (lm_lock_t *)lockspace;
> 
> 
> typedef abuse?
> 
The lock module interface has been left identical to that in GFS1 for
the time being so that it is possible to share lock modules between the
two versions. There are a few things which could be tidied up if we were
to change the interface, and we may well do that, but we've been holding
off as long as possible if only to make testing easier.

Since you've brought the subject up, we'll add it to out list :-) Thanks
for the suggestions,

Steve.


