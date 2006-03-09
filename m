Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbWCICW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbWCICW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWCICW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:22:28 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:40367 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932709AbWCICW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:22:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=W8yP63CCi3xBnX74kag8DHtpNiS9ze9wjzrTrKsNcelS7hllQ8i5QQ3CExxu0gBoQjA2O/Ar2qVxIsgjO3+Y9j0tto49t2PBkImp1eT6D8uv5tTNevBeN4At6C6hsoB80FWcvtbkLVGYNI4MhPos62JWfGQXtFNnb4BLjcBzSY4=  ;
Message-ID: <440F9154.2080909@yahoo.com.au>
Date: Thu, 09 Mar 2006 13:22:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org> <cone.1141774323.5234.18683.501@kolivas.org> <20060307160515.0feba529.akpm@osdl.org> <20060308222404.GA4693@elf.ucw.cz>
In-Reply-To: <20060308222404.GA4693@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>On Út 07-03-06 16:05:15, Andrew Morton wrote:
>
>>Why do you want that?
>>
>>If prefetch is doing its job then it will save the machine from a pile of
>>major faults in the near future.  The fact that the machine happens
>>
>
>Or maybe not.... it is prefetch, it may prefetch wrongly, and you
>definitely want it doing nothing when system is loaded.... It only
>makes sense to prefetch when system is idle.
>

Right. Prefetching is obviously going to have a very low work/benefit,
assuming your page reclaim is working properly, because a) it doesn't
deal with file pages, and b) it is doing work to reclaim pages that
have already been deemed to be the least important.

What it is good for is working around our interesting VM that apparently
allows updatedb to swap everything out (although I haven't seen this
problem myself), and artificial memory hogs. By moving work to times of
low cost. No problem with the theory behind it.

So as much as a major fault costs in terms of performance, the tiny
chance that prefetching will avoid it means even the CPU usage is
questionable. Using sched_yield() seems like a hack though.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
