Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWHBEhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWHBEhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWHBEhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:37:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:5508 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751153AbWHBEhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:37:03 -0400
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Xen-devel] Re: [PATCH 8 of 13] Add a bootparameter to reserve high linear address space for hypervisors
Date: Wed, 2 Aug 2006 06:36:58 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <0adfc39039c79e4f4121.1154462446@ezr> <200608020621.22827.ak@suse.de> <1154493226.2570.50.camel@localhost.localdomain>
In-Reply-To: <1154493226.2570.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020636.58133.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 06:33, Rusty Russell wrote:
> On Wed, 2006-08-02 at 06:21 +0200, Andi Kleen wrote:
> > > 	I think you misunderstand the purpose of parse_early_param?  It is
> > > designed to be called directly by the arch at some point (it is
> > > idempotent, so the second call in init/main.c does nothing if the arch
> > > has called it).  ie. in i386, it replaces parse_cmdline_early().
> > 
> > Ah I didn't realize that. But why is there a second call in init/main.c?  
> > Looks like a big hack to me. Someone was too lazy to add it to all architectures?
> 
> Yes.  Someone == me.  I didn't want to hack it into all archs, I wanted
> archs to actually use it, and you can see that's not a trivial patch...
> 
> Once all archs use it, we can probably clean up setup_arch() not to take
> the char** and simply use the global saved_command_line directly.  At
> this rate, that'll be around 2012 8)

Please just make a proper patch - either add a call to it to all setup_archs,
or add a call to before setup_arch in init/main.c. While such ifdefs
for specific architecture hacks are more popular lately it doesn't mean they are a good idea.

I hope there aren't any existing architectures that use it in the middle
of setup_arch or rely on it being after setup_arch.

-Andi
