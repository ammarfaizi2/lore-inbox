Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbTIQUwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTIQUwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:52:04 -0400
Received: from waste.org ([209.173.204.2]:32159 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262715AbTIQUwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:52:00 -0400
Date: Wed, 17 Sep 2003 15:51:50 -0500
From: Matt Mackall <mpm@selenic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: netpoll/netconsole minor tweaks
Message-ID: <20030917205150.GT4489@waste.org>
References: <20030917112447.A24623@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917112447.A24623@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 11:24:47AM -0700, Chris Wright wrote:
> Hi Matt,
> 
> Here's a couple small tweaks.  The first is to netpoll_setup.  The settle
> time was too short for my e100, and the system would hang.  

This probably ought to be a command line arg, my tg3 apparently
doesn't need it at all. One second is what's in the nfs-root stuff,
perhaps they need to share an arg, I changed it to two because my tlan
was dropping stuff (but not hanging - that may be a driver bug).
Ideally, I'd like to find a way to wait until the damn thing is up
before sending.

net/ipv4/ipconfig.c:
 /* Define the friendly delay before and after opening net devices */
 #define CONF_PRE_OPEN           (HZ/2)  /* Before opening: 1/2 second */
 #define CONF_POST_OPEN          (1*HZ)  /* After opening: 1 second */
 
Anyway, I'm still struggling with getting stuff working on my Opteron
box, care to take a stab at it?

> The second
> is to netconsole so that it registers a console with CON_PRINTBUFFER.
> This helps debugging early bootup issues where you want to capture data
> from before netconsole is initialized.  Perhaps it should be a param
> to netconsole?

I think this can probably be unconditional. Merged.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
