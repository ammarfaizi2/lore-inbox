Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWCVRSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWCVRSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWCVRSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:18:01 -0500
Received: from hera.kernel.org ([140.211.167.34]:33219 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750971AbWCVRSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:18:00 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Date: Wed, 22 Mar 2006 09:17:57 -0800
Organization: OSDL
Message-ID: <20060322091757.427f8ce8@localhost.localdomain>
References: <20060322063040.960068000@sorel.sous-sol.org>
	<20060322063808.464342000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1143047876 9986 10.8.0.54 (22 Mar 2006 17:17:56 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 22 Mar 2006 17:17:56 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006 22:31:14 -0800
Chris Wright <chrisw@sous-sol.org> wrote:

> The network device frontend driver allows the kernel to access network
> devices exported exported by a virtual machine containing a physical
> network device driver.
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---

In addition to earlier comments:

* should handle multiple interfaces, not just one static.

* the whole notifier fake arp call back is fugly

* use sysfs instead of /proc to handle the simple rxbuf_min,max stuff or use
  ethtool ring parameters

* proc module_owner not set, so ref counting not done.  Moot if you switch
  to sysfs.

* since you add ethtool for checksum,
  why not some basic stuff like driver info and carrier state?

* xen_net_read_mac seems like it could just be put inside driver.

* minor
	use free_netdev() rather than kfree in error path
	don't bother initializing .next/.priority in notifier_block if it is just 0

* what about mtu change?

* what about mac address change?

* Could you support scatter gather?


	
