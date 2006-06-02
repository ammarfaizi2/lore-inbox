Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWFBFH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWFBFH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFBFH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:07:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWFBFHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:07:25 -0400
Date: Thu, 1 Jun 2006 22:11:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci_walk_bus race condition
Message-Id: <20060601221141.d84bcf97.akpm@osdl.org>
In-Reply-To: <1149222942.8436.189.camel@ymzhang-perf.sh.intel.com>
References: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
	<20060526135039.GA13280@kroah.com>
	<1148863271.4377.521.camel@ymzhang-perf.sh.intel.com>
	<1148889932.4377.537.camel@ymzhang-perf.sh.intel.com>
	<1149222942.8436.189.camel@ymzhang-perf.sh.intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 12:35:43 +0800
"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:

> pci_walk_bus has a race with pci_destroy_dev. When cb is called
> in pci_walk_bus, pci_destroy_dev might unlink the dev pointed by next.
> Later on in the next loop, pointer next becomes NULL and cause
> kernel panic.
> 
> Below patch against 2.6.17-rc4 fixes it by changing pci_bus_lock (spin_lock)
> to pci_bus_sem (rw_semaphore).

How does s/spinlock/rwsem/ fix a race??
