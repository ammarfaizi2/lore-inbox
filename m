Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWHBEdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWHBEdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWHBEdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:33:49 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:27339 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751147AbWHBEdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:33:49 -0400
Subject: Re: [Xen-devel] Re: [PATCH 8 of 13] Add a bootparameter to reserve
	high linear address space for hypervisors
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <200608020621.22827.ak@suse.de>
References: <0adfc39039c79e4f4121.1154462446@ezr>
	 <p73lkq7zvu3.fsf@verdi.suse.de>
	 <1154490840.2570.37.camel@localhost.localdomain>
	 <200608020621.22827.ak@suse.de>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 14:33:45 +1000
Message-Id: <1154493226.2570.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 06:21 +0200, Andi Kleen wrote:
> > 	I think you misunderstand the purpose of parse_early_param?  It is
> > designed to be called directly by the arch at some point (it is
> > idempotent, so the second call in init/main.c does nothing if the arch
> > has called it).  ie. in i386, it replaces parse_cmdline_early().
> 
> Ah I didn't realize that. But why is there a second call in init/main.c?  
> Looks like a big hack to me. Someone was too lazy to add it to all architectures?

Yes.  Someone == me.  I didn't want to hack it into all archs, I wanted
archs to actually use it, and you can see that's not a trivial patch...

Once all archs use it, we can probably clean up setup_arch() not to take
the char** and simply use the global saved_command_line directly.  At
this rate, that'll be around 2012 8)

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

