Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965330AbVKGUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbVKGUry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbVKGUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:47:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:9106 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965330AbVKGUrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:47:52 -0500
Date: Mon, 7 Nov 2005 12:47:43 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] Memory Add Fixes for ppc64
Message-ID: <20051107204743.GC5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com> <20051104231800.GB25545@w-mikek2.ibm.com> <1131149070.29195.41.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131149070.29195.41.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 11:04:30AM +1100, Benjamin Herrenschmidt wrote:
> This patch will have to be slightly reworked on top of the 64k pages
> one. It should be trivial though.

Ran into an issue with the interaction of SPARSEMEM and 64k pages.
SPARSEMEM defines the pp64 section size to be 16MB which corresponds
to the smallest LMB size.  There is a check in the SPARSEMEM code
to ensure that MAX_ORDER (actually MAX_ORDER-1) block size is not
greater than section size.  Within the Kconfig file, there is this:

# We optimistically allocate largepages from the VM, so make the limit
# large enough (16MB). This badly named config option is actually
# max order + 1
config FORCE_MAX_ZONEORDER
        int
        depends on PPC64
        default "13"

Just curious if we still want to boost MAX_ORDER like this with 64k
pages?  Doesn't that make the MAX_ORDER block size 256MB in this case?
Also, not quite sure what happens if memory size (a 16 MB multiple)
does not align with a MAX_ORDER block size (a 256MB multiple in this
case).  My 'guess' is that the page allocator would not use it as it
would not fit within the buddy system.

cc'ing SPARSEMEM author Andy Whitcroft.
-- 
Mike
