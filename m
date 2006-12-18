Return-Path: <linux-kernel-owner+w=401wt.eu-S1754747AbWLRXQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbWLRXQZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbWLRXQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:16:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55098 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747AbWLRXQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:16:24 -0500
Subject: Re: [PATCH] Fix sparsemem on Cell
From: Dave Hansen <haveblue@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org,
       paulus@samba.org, mkravetz@us.ibm.com, gone@us.ibm.com,
       cbe-oss-dev@ozlabs.org
In-Reply-To: <200612182354.47685.arnd@arndb.de>
References: <20061215165335.61D9F775@localhost.localdomain>
	 <20061215114536.dc5c93af.akpm@osdl.org>
	 <20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
	 <200612182354.47685.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 15:16:20 -0800
Message-Id: <1166483780.8648.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 23:54 +0100, Arnd Bergmann wrote:
>  #ifndef __HAVE_ARCH_MEMMAP_INIT
>  #define memmap_init(size, nid, zone, start_pfn) \
> -	memmap_init_zone((size), (nid), (zone), (start_pfn))
> +	memmap_init_zone((size), (nid), (zone), (start_pfn), 1)
>  #endif

This is what I was thinking of.  Sometimes I find these kinds of calls a
bit annoying:

	foo(0, 1, 1, 0, 99, 22)

It only takes a minute to look up what all of the numbers do, but that
is one minute too many. :)

How about an enum, or a pair of #defines?

enum context
{
        EARLY,
        HOTPLUG
};
extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
                                enum call_context);
...

So, the call I quoted above would become:

	memmap_init_zone((size), (nid), (zone), (start_pfn), EARLY)

-- Dave

