Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWALTtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWALTtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWALTtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:49:08 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7071 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161220AbWALTtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:49:06 -0500
Subject: RE: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
From: Adam Litke <agl@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <200601121907.k0CJ7og16283@unix-os.sc.intel.com>
References: <200601121907.k0CJ7og16283@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 12 Jan 2006 13:48:59 -0600
Message-Id: <1137095339.17956.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 11:07 -0800, Chen, Kenneth W wrote:
> Sorry, I don't think patch 1 by itself is functionally correct.  It opens
> a can of worms with race window all over the place.  It does more damage
> than what it is trying to solve.  Here is one case:
> 
> 1 thread fault on hugetlb page, allocate a non-zero page, insert into the
> page cache, then proceed to zero it.  While in the middle of the zeroing,
> 2nd thread comes along fault on the same hugetlb page.  It find it in the
> page cache, went ahead install a pte and return to the user.  User code
> modify some parts of the hugetlb page while the 1st thread is still
> zeroing.  A potential silent data corruption.

I don't think the above case is possible because of find_lock_page().
The second thread would wait on the page to be unlocked by the thread
zeroing it before it could proceed.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

