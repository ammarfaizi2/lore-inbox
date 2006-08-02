Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWHBFVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWHBFVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWHBFVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:21:03 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:43470 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751230AbWHBFVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:21:02 -0400
Subject: Re: [Xen-devel] Re: [PATCH 8 of 13] Add a bootparameter to reserve
	high linear address space for hypervisors
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       virtualization@lists.osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <200608020636.58133.ak@suse.de>
References: <0adfc39039c79e4f4121.1154462446@ezr>
	 <200608020621.22827.ak@suse.de>
	 <1154493226.2570.50.camel@localhost.localdomain>
	 <200608020636.58133.ak@suse.de>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 15:20:57 +1000
Message-Id: <1154496058.2570.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 06:36 +0200, Andi Kleen wrote:
> Please just make a proper patch - either add a call to it to all setup_archs,
> or add a call to before setup_arch in init/main.c. While such ifdefs
> for specific architecture hacks are more popular lately it doesn't mean they are a good idea.

It's been around for two years, but if you fix x86_64 to use
early_param(), and I'll patch the other setup_archs to call
parse_early_param and remove the init/main.c call 8)

> I hope there aren't any existing architectures that use it in the middle
> of setup_arch or rely on it being after setup_arch.

setup_arch is responsible for grabbing the command line, so that has to
happen first.  Even on x86, functions later in setup_arch rely on
cmdline parsing having happened.  So for the moment setup_arch has to
call parse_early_param.

Maybe one day we can create a new "char *arch_get_cmdline()", implement
that everywhere, then call it and parse_early_param from core code.  But
baby steps...

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

