Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUENTPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUENTPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUENTPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:15:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54732
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262205AbUENTO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:14:57 -0400
Date: Fri, 14 May 2004 21:14:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040514191454.GJ3044@dualathlon.random>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513123809.01398f93.akpm@osdl.org> <20040513124249.J21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513124249.J21045@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 12:42:49PM -0700, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Chris Wright <chrisw@osdl.org> wrote:
> > >
> > > 
> > >  +static int capability_mask;
> > >  +module_param_named(mask, capability_mask, int, 0);
> > >  +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
> > 
> > Is there a way to make this tunable at runtime, btw?
> 
> Yeah, it'd require sysctl or similar, and further reduces the security,
> unless you only allow bit clearing or something.

the runtime switch would be more confortable, the config is:

ONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_CAPABILITIES_BOOTPARAM=y
CONFIG_SECURITY_ROOTPLUG=m
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
# CONFIG_SECURITY_SELINUX_MLS is not set

if the runtime switch needs sysctl then probably we can stay with
disable_cap_mlock or mlock_group (I prefer disable_cap_mlock because
having more sysctl doesn't make it more secure, if you can exploit
disable_cap_mlock you can exploit hugetlbfs_group and you can exploit
mlock_group too). It's an hack and the simplest hack is
disable_cap_mlock and it is more "featured" than the group that is only
available to one group of users at once.
