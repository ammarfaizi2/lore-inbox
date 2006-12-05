Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967727AbWLEFuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967727AbWLEFuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967623AbWLEFuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:50:40 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:23474 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S967727AbWLEFuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:50:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=J2Gipq67tK1I3qYf/kw7/JBKev7wA5+I+/gnJQBRVCxOyVWaCFnJflfYNjlUzwI1PpxRZA8N3Qdtibtz2S0yp1z+brHIMOGxwnxh+0bx5fTbmQ11C45Y49JMgKdhIF+06P1Vs1NDCJdGJNCDn0G267HQLgkkK0koxUhTSxPY4gI=  ;
X-YMail-OSG: IPuZYz4VM1lu.wihCc5QE2kwT66t.1yEwYcxlvUJA2bL5DvT2bSKAHqAsroYaWRTcdsIVgSuePSHv7gr5UzbRJh4.jM1VEghQhzV9nZjhSatn_Ke5ymk9ooPJUN0ZD354zRosBo0PEfPPhg-
Message-ID: <4575087C.6050906@yahoo.com.au>
Date: Tue, 05 Dec 2006 16:49:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
References: <20061204204024.2401148d.akpm@osdl.org> <17781.27.369430.322758@cargo.ozlabs.ibm.com>
In-Reply-To: <17781.27.369430.322758@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Andrew Morton writes:

>>radix-tree-rcu-lockless-readside.patch
>>
>> There's no reason to merge this yet.
> 
> 
> We want to use it in some powerpc arch code.  Currently we use a
> per-cpu array of spinlocks, and this patch would let us get rid of
> that array.

I'd like to get another patch in here before going upstream if possible.
It is not a correctness fix, but it is a bit of a rework.

I also wouldn't mind getting the readahead path, if not the full
pagecache readside, out from under tree_lock in -mm kernels to exercise
the radix-tree concurrency a bit more.

It's just been painfully slow, recently because of these more important
buffered write vs deadlock and pagefault vs invalidate problems that
I've been working on. I don't feel I can load up -mm with too much
unrelated stuff that messes with mm/pagecache internals.

I guess the per-cpu spinlocks are pretty reasonable for scalability,
and you are mainly looking to eliminate the lock/unlock cost in your
interrupt path?

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
