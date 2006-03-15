Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWCOWjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWCOWjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWCOWjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:39:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29578 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932513AbWCOWjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:39:47 -0500
Date: Wed, 15 Mar 2006 23:39:27 +0100
From: Pavel Machek <pavel@ucw.cz>
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
Subject: Re: [RFC, PATCH 2/24] i386 Vmi config
Message-ID: <20060315223927.GA1719@elf.ucw.cz>
References: <200603131800.k2DI0RfN005633@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131800.k2DI0RfN005633@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 13-03-06 10:00:27, Zachary Amsden wrote:
> Introduce the basic VMI sub-arch configuration dependencies.  VMI kernels only
> are designed to run on modern hardware platforms.  As such, they require a
> working APIC, and do not support some legacy functionality, including APM BIOS,
> ISA and MCA bus systems, PCI BIOS interfaces, or PnP BIOS (by implication of
> dropping ISA support).  They also require a P6 series CPU.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> 
> +menu "VMI configurable support"
> +	depends on X86_VMI
> +
> +config VMI_REQUIRE_HYPERVISOR
> +        bool "Require hypervisor"
> +        default n
> +        help
> +          This option forces the kernel to run with a hypervisor present.
> +          The kernel will panic if booted on native hardware.

This uses spaces instead of tabs...


> @@ -270,7 +295,7 @@ config X86_VISWS_APIC
>  
>  config X86_MCE
>  	bool "Machine Check Exception"
> -	depends on !X86_VOYAGER
> +	depends on !(X86_VOYAGER)
>  	---help---
>  	  Machine Check Exception support allows the processor to notify the
>  	  kernel if it detects a problem (e.g. overheating, component

And you probalby do not need this change.

> @@ -307,6 +332,7 @@ config X86_MCE_P4THERMAL
>  
>  config TOSHIBA
>  	tristate "Toshiba Laptop support"
> +	depends on !X86_VMI
>  	---help---
>  	  This adds a driver to safely access the System Management Mode of
>  	  the CPU on Toshiba portables with a genuine Toshiba BIOS. It

In the long run, we'd like to support toshiba laptops :-)

								Pavel
-- 
135:        uint Size;
