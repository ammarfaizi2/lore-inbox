Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUFYSjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUFYSjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUFYSjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:39:47 -0400
Received: from waste.org ([209.173.204.2]:6604 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266831AbUFYSjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:39:46 -0400
Date: Fri, 25 Jun 2004 13:39:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] teach netconsole how to do syslog
Message-ID: <20040625183935.GC25826@waste.org>
References: <16604.26514.243458.631948@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16604.26514.243458.631948@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 01:57:38PM -0400, Jeff Moyer wrote:
> Hello,
> 
> Here's a patch which adds the option to send messages to a remote syslog,
> enabled via the do_syslog= module parameter.  Currently logs everything at
> info (as did the original netconsole module).  Patch is against 2.6.6,
> though should apply to later.

Well as it stands, it's already syslog compatible, as the priority level
component of the syslog protocol is optional. I've made a point of
_defining_ the netconsole protocol as syslog (note the default port)
so that this could be done at a later date. Thus, I don't think a new
command line option is necessary.

On the other hand, for this to have real value, we need to provide
real priority levels. Which means we need to plug it in higher in the
printk framework so that we a) get all messages by default and b) get
them before the levels are stripped off. I had this in an earlier
version but dropped it as being too intrusive for 2.6.0 merger.

Also, if we're going to go to the trouble of being more completely
syslog-like, it's very useful (and trivial) to throw in the hostname
as well. Timestamp is slightly more difficult, but also worth
considering.

-- 
Mathematics is the supreme nostalgia of our time.
