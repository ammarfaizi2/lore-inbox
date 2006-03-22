Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWCVU7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWCVU7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWCVU7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:59:05 -0500
Received: from ns2.suse.de ([195.135.220.15]:7858 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932725AbWCVU7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:59:02 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 17/24] i386 Vmi msr patch
Date: Wed, 22 Mar 2006 21:21:32 +0100
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
References: <200603131812.k2DICGJE005747@zach-dev.vmware.com>
In-Reply-To: <200603131812.k2DICGJE005747@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222121.34117.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -#define rdtsc(low,high) \
> -     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
> -
> -#define rdtscl(low) \
> -     __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
> -
> -#define rdtscll(val) \
> -     __asm__ __volatile__("rdtsc" : "=A" (val))
> -
> -#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
> -
> -#define rdpmc(counter,low,high) \
> -     __asm__ __volatile__("rdpmc" \
> -			  : "=a" (low), "=d" (high) \
> -			  : "c" (counter))

The kernel doesn't use rdpmc. And moving rdtsc is useless
as I wrote earlier.

But mostly it is used from user space and you will break everything there.

-Andi
