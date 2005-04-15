Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVDOQBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVDOQBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVDOQBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:01:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:20371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261515AbVDOQBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:01:08 -0400
Date: Fri, 15 Apr 2005 09:01:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ted Kremenek <kremenek@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org, Bryan Fulton <bryan@coverity.com>,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] possible missing capability check in ioctl function, drivers/net/cris/eth_v10.c, kernel 2.6.11
Message-ID: <20050415160104.GB23013@shell0.pdx.osdl.net>
References: <b86e6e6214dbc3ebe14bf1ec472a1202@cs.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86e6e6214dbc3ebe14bf1ec472a1202@cs.stanford.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ted Kremenek (kremenek@cs.stanford.edu) wrote:
> In several network drivers that handle the ioctl command SIOCSMIIREG 
> (writes a register on the network card) most implementations check for 
> the CAP_NET_ADMIN capability.  Several drivers use the function 
> "generic_mii_ioctl" to process this command (defined in 
> drivers/net/mii.c).  In mii.c, we see:

This, to me, looks like the device specific (or generic_mii_ioctl)
capability test winds up being redundant.  The top-level checks
capabilities already in net/dev/core.c::dev_ioctl().  So, while there's
some room for cleanup, I don't think this is an acutal bug.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
