Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWFUV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWFUV4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWFUV4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:56:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:55534 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030312AbWFUV4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:56:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=UJ0fFxcSZZ0qdnHsmALODpUTw9zF4lHc00kvc8DrW8Ks5S3748zU0jOBkZx+5tEej
	qQqJr57JzGR64Xqo9saGg==
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <p73zmg6oo5t.fsf@verdi.suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <p73zmg6oo5t.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 21 Jun 2006 14:54:42 -0700
Message-Id: <1150926882.6885.32.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 11:26 +0200, Andi Kleen wrote:
> Chuck Ebbert <76306.1226@compuserve.com> writes:
> 
> > Use a GDT entry's limit field to store per-cpu data for fast access
> > from userspace, and provide a vsyscall to access the current CPU
> > number stored there.
> 

Very clever.  

> Just the CPU alone is useless - you want at least the node too in many
> cases. Best you use the prototype I proposed earlier for x86-64.
> 

Can we use similar  mechanism to access pda in vsyscall in x86_64 (by
storing the address of pda there).  That way the useful variables like
cpunumber, nodenumber can be accessed easily without doing cpuid (and
without tcache).  The system call can take a flag like GET_CPUNUMBER or
GET_NODENUMBER or GET_NMICOUNT or if anything new gets added in this
structure.

-rohit

