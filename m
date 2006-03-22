Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbWCVU72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWCVU72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWCVU7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:59:13 -0500
Received: from ns2.suse.de ([195.135.220.15]:10418 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932728AbWCVU7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:59:04 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 10/24] i386 Vmi descriptor changes
Date: Wed, 22 Mar 2006 21:24:01 +0100
User-Agent: KMail/1.9.1
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
References: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com>
In-Reply-To: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222124.03284.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -#define _set_gate(gate_addr,type,dpl,addr,seg) \
> -do { \
> -  int __d0, __d1; \
> -  __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
> -	"movw %4,%%dx\n\t" \
> -	"movl %%eax,%0\n\t" \
> -	"movl %%edx,%1" \
> -	:"=m" (*((long *) (gate_addr))), \
> -	 "=m" (*(1+(long *) (gate_addr))), "=&a" (__d0), "=&d" (__d1) \
> -	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
> -	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
> -} while (0)


The ugly piece of code doesn't do anything priviledged. So why do you want
to move it?

-Andi

