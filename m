Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVHZSUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVHZSUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVHZSUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:20:39 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:32573 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965170AbVHZSUi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:20:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rYu54ZxQow7z9LzmkOZUGwuHPdnMQVgsBBkSrs3zny/Xy3XMZ3RPkteN0zID/4z/WAeL7cESAy9LCI3vwdWJdDlAoEaIg3IiNl8KzZc/Qox3SlLtV6bcJzbLKn5s+XTMm23eLwrUzwycNHVL/ntJ3RgLubejaoRzbNPETlqEv7o=
Message-ID: <8783be6605082611206dce314e@mail.gmail.com>
Date: Fri, 26 Aug 2005 11:20:37 -0700
From: Ross Biro <ross.biro@gmail.com>
To: Rik van Riel <riel@redhat.com>
Subject: Re: process creation time increases linearly with shmem
Cc: Ray Fucillo <fucillo@intersystems.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508261349550.25015@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
	 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
	 <430E6FD4.9060102@yahoo.com.au>
	 <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
	 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
	 <430F26AA.80901@yahoo.com.au> <430F4A9E.3060903@intersystems.com>
	 <Pine.LNX.4.63.0508261349550.25015@cuia.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Rik van Riel <riel@redhat.com> wrote:
> 
> Filling in all the page table entries at the first fault to
> a VMA doesn't make much sense, IMHO.
> 
> 
> I suspect we would be better off without that extra complexity,
> unless there is a demonstrated benefit to it.

You are probably right, but do you want to put in a patch that might
have a big performance impact in either direction with out verifying
it?

My suggestion is safe, but most likely sub-optimal.  What everyone
else is suggesting may be far better, but needs to be verified first.

I'm suggesting that we change the code to do the same work fork would
have done on the first page fault immediately, since it's easy to
argue that it's not much worse than we have now and much better in
many cases, and then try to experiment and figure out  what the
correct solution is.

    Ross
