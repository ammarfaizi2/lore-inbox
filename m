Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVIEQcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVIEQcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIEQcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:32:41 -0400
Received: from [81.2.110.250] ([81.2.110.250]:63637 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932331AbVIEQcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:32:39 -0400
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <431A4767.4030403@yahoo.com.au>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
	 <4317F136.4040601@yahoo.com.au>
	 <1125666486.30867.11.camel@localhost.localdomain>
	 <p73k6hzqk1w.fsf@verdi.suse.de>  <4318C28A.5010000@yahoo.com.au>
	 <1125705471.30867.40.camel@localhost.localdomain>
	 <4318FF2B.6000805@yahoo.com.au>
	 <1125768697.14987.7.camel@localhost.localdomain>
	 <431A4767.4030403@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Sep 2005 09:20:18 +0100
Message-Id: <1125822018.23858.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-04 at 11:01 +1000, Nick Piggin wrote:
> I would be surprised if it was a big loss... but I'm assuming
> a locked cmpxchg isn't outlandishly expensive. Basically:
> 
>    read_lock_irqsave(cacheline1);
>    atomic_inc_return(cacheline2);
>    read_unlock_irqrestore(cacheline1);
> 
> Turns into
> 
>    atomic_cmpxchg();
> 
> I'll do some microbenchmarks and get back to you. I'm quite
> interested now ;) What sort of AMDs did you have in mind,


Athlon or higher give very different atomic numbers to P4. If you are
losing the read_lock/unlock then the atomic_cmpxchg should be faster on
all I agree.

One question however - atomic_foo operations are not store barriers so
you might need mb() and friends for PPC ?

Alan

