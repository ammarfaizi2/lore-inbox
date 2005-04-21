Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVDULyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVDULyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVDULya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:54:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:57491 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261316AbVDULy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:54:26 -0400
Date: Thu, 21 Apr 2005 13:54:25 +0200
From: Andi Kleen <ak@suse.de>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more comments
Message-ID: <20050421115425.GT7715@wotan.suse.de>
References: <894E37DECA393E4D9374E0ACBBE74270013E8B90@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894E37DECA393E4D9374E0ACBBE74270013E8B90@pdsmsx402.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another comment:

In general I am not too happy about the variable size TASK_SIZE.
There was a patch for this earlier, but it broke 32bit emulation
completely. And I think it needs auditing of all uses of TASK_SIZE,
because I suspect there are more bugs lurking in it.

The way hugetlb etc. mmap were supposed to be handled was to 
let the mmap succeed and then check in the mmap wrapper
if any address is > 4GB and free it. Probably that code
has some problems or got broken (I think it worked at least
in 2.4, but there might have been regressions later)

-Andi
