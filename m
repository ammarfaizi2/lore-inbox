Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVC2Bvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVC2Bvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVC2Bvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:51:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4522 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262143AbVC2Bvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:51:38 -0500
Date: Mon, 28 Mar 2005 17:50:21 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <20050325014411.GA7698@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0503281745290.7531@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050325014411.GA7698@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, Pavel Machek wrote:

> > +unsigned int sysctl_scrub_start = 100;	/* Min percentage of zeroed free pages per zone (~10% default) */
> > +unsigned int sysctl_scrub_stop = 300;	/* Max percentage of zeroed free pages per zone (~30% default) */
> > +unsigned int sysctl_scrub_load = 1;	/* Do not run scrubd if load > */
> Perhaps that variable should be called sysctl_scrub*d*_load?

Hmm. Ok they are all now _scrubd_ instead..

> > +	Scrubd is woken up if the system load is lower than this setting and
> > +	the numer of unzeroed free pages drops below scrub_start*10 percent.
> > +	The default setting of 1 insures that there will be no performance
> > +	degradation in single user mode. In an SMP system a cpu is frequently
> > +	idle despite the load being high. A setting of 9 or 99 may
> > +	be useful then.
>
> I don't think 1 guarantees no performance degradation. After all, it
> is average load and scrubd might run at just the wrong times. Perhaps
> it should default to 0?

Correct. Changed the wording. Not sure about setting it to zero since its
an experimental feature set to off by default. If one enables scrubd then
the presumably something should be happening.

