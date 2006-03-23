Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWCWCVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWCWCVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 21:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWCWCVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 21:21:18 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:26215 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932068AbWCWCVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 21:21:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uBC6OmjCCi8JiAE65lFiZNBS8YIIMl98WqeZ67aeeZ383kLA/ZewTSjxWjg/2bXDCk/kgy+i1W+TzdUOv2rT4+Ynd9x/Ycbj82d8pdWgC+LozfXFjKL7MN7JV63twFnp+eFP2cJ4Hg+wK9R2HioskePH83kqgJpe0I/zmHmDR7I=  ;
Message-ID: <44220614.1090101@yahoo.com.au>
Date: Thu, 23 Mar 2006 13:21:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, iwamoto@valinux.co.jp,
       christoph@lameter.com, wfg@mail.ustc.edu.cn, npiggin@suse.de,
       torvalds@osdl.org, riel@redhat.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
References: <20060322223107.12658.14997.sendpatchset@twins.localnet> <20060322145132.0886f742.akpm@osdl.org>
In-Reply-To: <20060322145132.0886f742.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
>>
>>This patch-set introduces a page replacement policy framework and 4 new 
>>experimental policies.
> 
> 
> Holy cow.
> 
> 
>>The page replacement algorithm determines which pages to swap out.
>>The current algorithm has some problems that are increasingly noticable, even
>>on desktop workloads.
> 
> 
> Rather than replacing the whole lot four times I'd really prefer to see
> precise descriptions of these problems, see if we can improve the situation
> incrementally rather than wholesale slash-n-burn...
> 

The other thing is that a lot of the "policy" stuff you've abstracted
out is actually low-level "mechanism" stuff that has implications beyond
page reclaim. Taking a refcount on lru pages, for example.

Also, as you work and find incremental improvements to the current code,
you should be submitting them (eg. patch 25, or patch 1) rather than
sitting on them and sending them in a huge patchset where they don't
really belong.

Some of the API names aren't very nice either. It's great that you want
to keep the namespace consistent, but it shouldn't be at the expense of
more descriptive names, and having the page_replace_ prefix itself makes
many functions read like crap. I'd suggest something like a pgrep_
prefix and try to make the rest of the name make sense.

Aside from all that, I'm with Andrew in that problems need to be
identified first and foremost. But also I don't like the chances of this
whole framework flying at all -- Linus vetoed a similar framework for
sched.c that was actually a reasonable API, with little or no
consequences outside sched.c. With good reason.

Nice work, though :)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
