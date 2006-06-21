Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWFUXTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWFUXTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWFUXTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:19:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:55323 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030459AbWFUXTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:19:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=hLuqE0g/Ewgo0DVXY+xPgwLxByf9w0v1UBibKXsIwnC6skegQOvNqvqnczPKfX2l7
	DJsdmxwUmOAVSr0OtZRKg==
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606220105.18512.ak@suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <200606220021.21657.ak@suse.de>
	 <1150930751.6885.61.camel@galaxy.corp.google.com>
	 <200606220105.18512.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 21 Jun 2006 16:18:42 -0700
Message-Id: <1150931922.6885.72.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 01:05 +0200, Andi Kleen wrote:
> On Thursday 22 June 2006 00:59, Rohit Seth wrote:

> > I was thinking of storing it is base address part of the descriptor and
> > then using the memory load to read it in vsyscall.  (Keeping the p bit
> > to zero in the descriptor).
> 
> I'm still not sure where and for what you want to use this. In user space 
> or in kernel space? And what information should be stored in there?
> 

Store the kernel virtual pointer in gdt to access pda in (proposed)
vgetcpu in vsyscall.  Using this pointer we can easily reach the cpu and
node numbers and any other information that is there in pda.  For the
cpu and node numbers this will get rid of the need to do a serializing
operation cpuid.

Does it make any sense?


> > Besides, not having to use the tcache part in the proposed system call
> > seems to just make the interface cleaner. 
> 
> tcache is still far faster than LSL (which is slower than RDTSCP) 

Since we are not using the limits part of the descriptor so lsl will not
be needed.  Though an indirect load from  gdt page will be made.

-rohit

