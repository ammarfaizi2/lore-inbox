Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTJXWVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTJXWVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:21:48 -0400
Received: from palrel11.hp.com ([156.153.255.246]:41950 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262680AbTJXWVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:21:43 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16281.42485.151214.829243@napali.hpl.hp.com>
Date: Fri, 24 Oct 2003 15:21:41 -0700
To: "Luck, Tony" <tony.luck@intel.com>
Cc: <davidm@hpl.hp.com>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
Subject: RE: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F36EB@scsmsx401.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F36EB@scsmsx401.sc.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 24 Oct 2003 15:16:59 -0700, "Luck, Tony" <tony.luck@intel.com> said:

  Tony> This patch was accepted into 2.5.55, attributed to "davej@uk".
  Tony> This code will prefetch from beyond the end of the page table
  Tony> being cleared ... which is clearly a bad thing if the page
  Tony> table in question is allocated from the last page of memory
  Tony> (or precedes a hole on a discontig mem system).

  >> Different arches behave differently, though.  In the case of ia64,
  >> it'a always safe to prefetch (even with lfetch.fault).

  Tony> Not quite always ... this was how I found the efi trim.bottom
  Tony> bug, since Linux had allocated a pgd at 0xa00000-16k, and the
  Tony> lfetch that reached out beyond the end of the page to the
  Tony> uncacheable address 0xa00000 took an MCA.

But don't confuse cause and effect!  The MCA was caused by a bad TLB
entry.  The lfetch only triggered the latent bug (as might have a
instruction-prefetch).

  Tony> A pgd in the last page of a granule that is followed by an uncacheable
  Tony> address would do the same with lfetch.fault, wouldn't it?

No, lfetch to uncacheable translations have no effect.

	--david
