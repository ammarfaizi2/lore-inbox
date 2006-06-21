Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWFUW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWFUW7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWFUW7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:59:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:6676 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030353AbWFUW7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:59:36 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=TjTZtw7wqJ+2OaF+725qy+YoXUrlfnTFEbDAs6I29FWPHi0+2wRfkZ7hDjANA1WAc
	RPAg0cajtrzI7xU65+1HA==
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606220021.21657.ak@suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <p73zmg6oo5t.fsf@verdi.suse.de>
	 <1150926882.6885.32.camel@galaxy.corp.google.com>
	 <200606220021.21657.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 21 Jun 2006 15:59:11 -0700
Message-Id: <1150930751.6885.61.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 00:21 +0200, Andi Kleen wrote:
> > Can we use similar  mechanism to access pda in vsyscall in x86_64 (by
> > storing the address of pda there).  
> 
> 
> You mean in the kernel? %gs prefix is a lot faster than this.
> 

Yes it is.  And will work if we are okay to swap to kernel gs in
vsyscall code.

> Also the limit is only 20bit, not enough for a full address.
> 

I was thinking of storing it is base address part of the descriptor and
then using the memory load to read it in vsyscall.  (Keeping the p bit
to zero in the descriptor).

> For user space it's useful though, but I don't see any immediate uses
> other than cpu number and node number. For most purposes glibc TLS
> (which uses %fs) is probably sufficient.

cpu and node number are really important (for the reasons that you
mentioned in your initial mail on vgetcpu).  In addition to that I was
thinking in terms of having some counters like nmi_count that is already
there and per cpu specific.

Besides, not having to use the tcache part in the proposed system call
seems to just make the interface cleaner. 

-rohit



