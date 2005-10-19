Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVJSV7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVJSV7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVJSV7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:59:46 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:20438 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751375AbVJSV7o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:59:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FVycgn845aUtsOgt36kfBPyY2qw7q6stTkvOVh9F1k7dne5Bf/rekFgskHcKt1XCPCQZGRdRo6CQlvZrvOTMAIGbRMhWswEFgMIcTGYgOUqogxevokd+cO1S+WVsd8mq47WdW7UZc3NlW3h2eWSBBDnUAxqeNM2uQBkWuigxKcA=
Message-ID: <12c511ca0510191459q63468bf5uff9b4bf47a3274ae@mail.gmail.com>
Date: Wed, 19 Oct 2005 14:59:44 -0700
From: Tony Luck <tony.luck@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for 2.6.14-rc4-git5
Cc: Rohit Seth <rohit.seth@intel.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510191345420.3369@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051018141512.A26194@unix-os.sc.intel.com>
	 <20051018143438.66d360c4.akpm@osdl.org>
	 <1129673824.19875.36.camel@akash.sc.intel.com>
	 <20051018172549.7f9f31da.akpm@osdl.org>
	 <1129692330.24309.44.camel@akash.sc.intel.com>
	 <Pine.LNX.4.61.0510191551180.7586@goblin.wat.veritas.com>
	 <1129747647.339.78.camel@akash.sc.intel.com>
	 <Pine.LNX.4.64.0510191345420.3369@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/05, Linus Torvalds <torvalds@osdl.org> wrote:
> (Of course, you can and maybe do handle it differently: you can also
> decide to just take the TLB fault, and flush the TLB at fault time in your
> handler. I don't see that either on ia64, though. Although I didn't look
> into any of the asm code, so maybe it's hidden somewhere there).

Yes.  In arch/ia64/kernel/ivt.S:

ENTRY(page_not_present)
        DBG_FAULT(20)
        mov r16=cr.ifa
        rsm psr.dt
        /*
         * The Linux page fault handler doesn't expect non-present
pages to be in
         * the TLB.  Flush the existing entry now, so we meet that expectation.
         */
        mov r17=PAGE_SHIFT<<2
        ;;
        ptc.l r16,r17

-Tony
