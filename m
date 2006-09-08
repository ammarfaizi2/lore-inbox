Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWIHTyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWIHTyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWIHTyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:54:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWIHTyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:54:20 -0400
Date: Fri, 8 Sep 2006 12:50:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brandon Philips <brandon@ifup.org>
Cc: linux-kernel@vger.kernel.org, Brice Goglin <brice@myri.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
Message-Id: <20060908125053.c31b76e9.akpm@osdl.org>
In-Reply-To: <20060908194300.GA5901@plankton.ifup.org>
References: <20060908174437.GA5926@plankton.ifup.org>
	<20060908121319.11a5dbb0.akpm@osdl.org>
	<20060908194300.GA5901@plankton.ifup.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 14:43:00 -0500
Brandon Philips <brandon@ifup.org> wrote:

> On 12:13 Fri 08 Sep 2006, Andrew Morton wrote:
> > On Fri, 8 Sep 2006 12:44:37 -0500
> > Brandon Philips <brandon@ifup.org> wrote:
> > > 2.6.18-rc4-mm3 boots ok.
> > > 
> > > I will try and bisect the problem later tonight-
> > 
> > Thanks.  First, try disabling CONFIG_PCI_MSI.
> 
> With CONFIG_PCI_MSI disabled the system boots.  

OK, thanks.

So likely candidates are:

- Brice's MSI changes

- The conversion of i386 to use the genirq code

- Eric's MSI/genirq changes

or a combination of the above.  Or something else.

<adds ccs, steps back expectantly>

> However, udev seems to very upset about network device names:
> 
> [udevd:3951]: Changing netdevice name from [eth1_temp] to [eth0]
> 
> That showed up a few hundred times.  I am running version 093 so I will
> try updating that later.

That's OK - it's a debug patch which was added to help us work out why one
or two people's net device names are getting trashed.  In fact we tracked
it down to some silliness in NetworkMonitor, regarding which certain parties
have yet to respond, iirc.

