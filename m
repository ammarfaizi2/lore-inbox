Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWC1JsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWC1JsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWC1JsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:48:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:63363 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750728AbWC1JsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:48:19 -0500
From: Andi Kleen <ak@suse.de>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: RFC - Approaches to user-space probes
Date: Tue, 28 Mar 2006 11:47:57 +0200
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       prasanna@in.ibm.com, suparna@in.ibm.com,
       "Theodore Ts'o" <tytso@mit.edu>
References: <OF74E934C4.97847922-ON8025713F.00310595-8025713F.00355BC1@uk.ibm.com>
In-Reply-To: <OF74E934C4.97847922-ON8025713F.00310595-8025713F.00355BC1@uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603281147.59382.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 11:42, Richard J Moore wrote:

> 1) ptrace is orientated to debugging a specific process tree and a
> nominated debug process. Having it operate on arbitrary process would
> require kernel extensions to achieve that but would also have a major
> impact on performance if each event were to result in a context switch to
> the debugger process.

You can attach it to any pid 

The problem is just finding new processes when they are created. And when
you trace all it will be quite inefficient.

> 
> 2) ptrace operates by privatizing memory via COW, but kprobes doesn't. The
> probes are fixed-up when a page is brought into memory by using an alias
> r/w virtual address. Using existing the ptrace mechanism across all, or
> most, processes could have a significant affect on swapfile and paging
> rate. And that has to be bad news when investigating performance and race
> conditions problems.

The problem with ptrace is also that it is quite heavyweight - you have
to take over all signals at least etc. Some lighter weight probing
mechanism for user space would be probably a good idea.

> If we want to make life easier for debugging the types of problems
> indicated above, then it's seems very reasonable to ask whether ptrace can
> be extended to use the (user) kprobes mechanism.

It's a mistery to me why people hate ioctl and like ptrace.

ptrace already is far too complex and ugly. Clean new calls would be probably
preferable. 

-Andi
