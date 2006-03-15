Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWCOC4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWCOC4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 21:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWCOC4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 21:56:31 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1408 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932288AbWCOC4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 21:56:30 -0500
Date: Tue, 14 Mar 2006 19:01:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 8/24] i386 Vmi syscall assembly
Message-ID: <20060315030115.GO12807@sorel.sous-sol.org>
References: <200603131805.k2DI5BVv005686@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131805.k2DI5BVv005686@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> These changes are sufficient to glue the Linux low level entry points to
> hypervisor event injection by emulating the native processor exception
> frame interface.

There's a bit more going on in the Xen changes to entry.S.  The STI/CLI
abstraction definitely gets partway there.  Then there's some bits that
use (in your terms) __STI, __CLI.  It's in code that's a pure addition
so it's tempting to simply make a mechanism for the additions, but it's a bit
too intertwined to just separate that code, as there's calls from core
entry.S into the Xen additions.

> N.B. Sti; Sysexit is a required abstraction, as the STI instruction implies
> holdoff of interrupts, which is destroyed by any NOP padding.

Or just disable systenter ;-)  Random question...do you support systenter?
Sounds slower than int80, since it should require 3->0->1->0->3 transitions.
Just idly curious if you've done benchmarks to see the difference.

thanks,
-chris
