Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUFZDts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUFZDts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 23:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265470AbUFZDts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 23:49:48 -0400
Received: from waste.org ([209.173.204.2]:52914 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262905AbUFZDtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 23:49:46 -0400
Date: Fri, 25 Jun 2004 22:48:39 -0500
From: Matt Mackall <mpm@selenic.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] teach netconsole how to do syslog
Message-ID: <20040626034838.GF25826@waste.org>
References: <20040625191101.GD25826@waste.org> <25929.1088216806@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25929.1088216806@ocs3.ocs.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 12:26:46PM +1000, Keith Owens wrote:
> On Fri, 25 Jun 2004 14:11:01 -0500, 
> Matt Mackall <mpm@selenic.com> wrote:
> >Yep, we get one UDP packet per printk currently, which works for most
> >things, but not everything. This could be changed to a buffered
> >approach, but that breaks one of my favorite debugging techniques -
> >adding an alphabet soup of single-character printks to trace tricky
> >call paths. 
> >
> >So we could add a __printk that doesn't flush to outputs for stuff
> >like the above, or just live with it.
> 
> Other way round.  Keep printk as is and use a buffered approach for
> printk over netconsole.  netconsole gets complete lines which is what
> you want 99.9% of the time. Add __printk or printk_unbuffered for the
> .1% of debugging output that really wants unbuffered output.

I think it's a bit too radical. The only user who cares is netconsole,
and then only when fed to syslogd. Using a client like netcat, the
current behavior is what you want. So while I think this might have
been the way to do it in the first place, changing the behavior of
every printk in the system in a way that might prevent information
from making it to the console in a crash seems like much more trouble
than removing the flush for the few cases that want to do multiple
printks per line and are making a minor mess with syslog. The
non-flushing __printk approach let's us choose when and where we want
to remove flushes.

But my current position is "just live with it".

-- 
Mathematics is the supreme nostalgia of our time.
