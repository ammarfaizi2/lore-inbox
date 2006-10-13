Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWJMAED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWJMAED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWJMAEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:04:01 -0400
Received: from twin.jikos.cz ([213.151.79.26]:3549 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751347AbWJMAEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:04:00 -0400
Date: Fri, 13 Oct 2006 02:03:28 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Phil Blundell <philb@gnu.org>, Tim Waugh <tim@cyberelk.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-parport@lists.infradead.org
Subject: Re: [PATCH] fix parport_serial_pci_resume() ignoring return value
 from pci_enable_device()
In-Reply-To: <20061012235820.GC24658@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610130200580.29022@twin.jikos.cz>
References: <Pine.LNX.4.64.0610130139510.29022@twin.jikos.cz>
 <20061012235820.GC24658@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Russell King wrote:

> In this case, you're calling parport_serial_pci_remove() in the failure 
> path.  That's fine, but this opens the possibility of it being called 
> twice - once on resume failure and once when the device/driver is 
> removed.  If this happens, we dereference a NULL pointer. *BAD*.

You are right, I missed this.

I am not currently sure what the proper fix is, though. We might be also 
ending doing very bad things, when we ignore the error returned by 
pci_enable_device() and proceed operating on non-existing device.

Thanks for spotting this,

-- 
Jiri Kosina
