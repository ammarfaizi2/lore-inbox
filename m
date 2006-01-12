Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbWALUHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbWALUHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWALUHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:07:15 -0500
Received: from fmr22.intel.com ([143.183.121.14]:17117 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161235AbWALUHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:07:12 -0500
Message-Id: <200601122006.k0CK6Sg17146@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>
Cc: "William Lee Irwin III" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
Date: Thu, 12 Jan 2006 12:06:29 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYXsX0jEz3WeSkDSuSR67+DuRaUZQAAgPAw
In-Reply-To: <1137095339.17956.22.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Thursday, January 12, 2006 11:49 AM
> On Thu, 2006-01-12 at 11:07 -0800, Chen, Kenneth W wrote:
> > Sorry, I don't think patch 1 by itself is functionally correct.  It opens
> > a can of worms with race window all over the place.  It does more damage
> > than what it is trying to solve.  Here is one case:
> > 
> > 1 thread fault on hugetlb page, allocate a non-zero page, insert into the
> > page cache, then proceed to zero it.  While in the middle of the zeroing,
> > 2nd thread comes along fault on the same hugetlb page.  It find it in the
> > page cache, went ahead install a pte and return to the user.  User code
> > modify some parts of the hugetlb page while the 1st thread is still
> > zeroing.  A potential silent data corruption.
> 
> I don't think the above case is possible because of find_lock_page().
> The second thread would wait on the page to be unlocked by the thread
> zeroing it before it could proceed.

I think you are correct.  Sorry for the noise.

- Ken

