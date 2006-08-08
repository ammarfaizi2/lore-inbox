Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWHHPg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWHHPg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWHHPg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:36:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:41897 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964959AbWHHPgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:36:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A4lH7EjTopy2yUeHcJriPA2T7b1jAc3kpSDJOJhvATN4y7JtmSEkkagrVpYPyZju6CVWWHIUlYulacIZYpaBFMq3rsV5oyB3RDLcVs9AyteP+QwiU18MQ6yF6rWJ4s4zUCXY3PTTb94gSKZZQaNRgcQsbMUxmFfBuXHmSN7t87w=
Message-ID: <a36005b50608080836u3e58ab85l61bb50b2bac5a0e3@mail.gmail.com>
Date: Tue, 8 Aug 2006 08:36:23 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] NUMA futex hashing
Cc: "Eric Dumazet" <dada1@cosmosbay.com>, "Andi Kleen" <ak@suse.de>,
       "Ravikiran G Thirumalai" <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "pravin b shelar" <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D8A9BE.3050607@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808070708.GA3931@localhost.localdomain>
	 <200608081429.44497.dada1@cosmosbay.com>
	 <200608081447.42587.ak@suse.de>
	 <200608081457.11430.dada1@cosmosbay.com>
	 <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>
	 <44D8A9BE.3050607@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Let me get this straight: to insert a contended futex into your rbtree,
> you need to hold the mmap sem to ensure that address remains valid,
> then you need to take a lock which protects your rbtree.

Why does it have to remain valid?  As long as the kernel doesn't crash
on any of the operations associated with the futex syscalls let the
address space region explode, implode, whatever.  It's  a bug in the
program if the address region is changed while a futex is placed
there.  If the futex syscall hangs forever or returns with a bogus
state (error or even success) this is perfectly acceptable.  We
shouldn't slow down correct uses just to make it possible for broken
programs to receive a more detailed error description.
