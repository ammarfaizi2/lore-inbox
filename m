Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWCOXYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWCOXYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWCOXYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:24:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54403 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750787AbWCOXYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:24:12 -0500
Date: Thu, 16 Mar 2006 00:23:53 +0100
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
Subject: Re: [RFC, PATCH 10/24] i386 Vmi descriptor changes
Message-ID: <20060315232352.GC1919@elf.ucw.cz>
References: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static inline void vmi_write_gdt(void *gdt, unsigned entry, u32 descLo, u32 descHi)
> +{
> +	vmi_wrap_call(
> +		WriteGDTEntry, "movl %2, (%0,%1,8);"
> +			       "movl %3, 4(%0,%1,8);",
> +		VMI_NO_OUTPUT,
> +		4, XCONC(VMI_IREG1(gdt), VMI_IREG2(entry), VMI_IREG3(descLo), VMI_IREG4(descHi)),
> +		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
> +}

I'd say "not funny" here. Very little comments for very obscure
code. "movl %3, 4(%0,%1,8);" is particulary "interesting".

> +static inline void write_gdt_entry(void *gdt, int entry, __u32 entry_a, __u32 entry_b)
> +{
> +        vmi_write_gdt(gdt, entry, entry_a, entry_b);
> +}

You should be able to use u32 (not __u32) here.
								Pavel

-- 
142:        byte [] Bytes = new byte[ 4 ];
