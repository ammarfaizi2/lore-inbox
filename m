Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWCNGgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWCNGgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWCNGgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:36:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14467 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750736AbWCNGgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:36:36 -0500
Date: Mon, 13 Mar 2006 22:41:07 -0800
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
Subject: Re: [RFC, PATCH 7/24] i386 Vmi memory hole
Message-ID: <20060314064107.GK12807@sorel.sous-sol.org>
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131804.k2DI4N6s005678@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Create a configurable hole in the linear address space at the top
> of memory.  A more advanced interface is needed to negotiate how
> much space the hypervisor is allowed to steal, but in the end, it
> seems most likely that a fixed constant size will be chosen for
> the compiled kernel, potentially propagated to an information
> page used by paravirtual initialization to determine interface
> compatibility.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> 
> Index: linux-2.6.16-rc3/arch/i386/Kconfig
> ===================================================================
> --- linux-2.6.16-rc3.orig/arch/i386/Kconfig	2006-02-22 16:09:04.000000000 -0800
> +++ linux-2.6.16-rc3/arch/i386/Kconfig	2006-02-22 16:33:27.000000000 -0800
> @@ -201,6 +201,15 @@ config VMI_DEBUG
>  
>  endmenu
>  
> +config MEMORY_HOLE
> +	int "Create hole at top of memory (0-256 MB)"
> +	range 0 256
> +	default "64" if X86_VMI
> +	default "0" if !X86_VMI

Deja-vu ;-)  And still works in context of Xen, but we've just let the
subarch define the __FIXADDR_TOP.  Having it be dynamic could be
interesting.
