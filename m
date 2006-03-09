Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWCIC6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWCIC6D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWCIC6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:58:03 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:59542 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751518AbWCIC6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:58:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=io9gbLktFNxoV4mKkPemyV5Zw0XV73Im9PTlqZR8jTylIscw5wq2oX0ugaksOCVNDXkKAPY87VITSm1vPDKQuQbquOIGJT+tRTn3LBw+UokDvc9d6LkcDMzvyDh+hkPYUXvlDRdfNBnDlkN8DEXWfuRP1DXBSuNAnpXcoZPELDU=  ;
Message-ID: <440F99AF.8050706@yahoo.com.au>
Date: Thu, 09 Mar 2006 13:57:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
References: <200603081013.44678.kernel@kolivas.org> <20060308222404.GA4693@elf.ucw.cz> <440F9154.2080909@yahoo.com.au> <200603091330.14396.kernel@kolivas.org>
In-Reply-To: <200603091330.14396.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Thu, 9 Mar 2006 01:22 pm, Nick Piggin wrote:
>
>>
>>So as much as a major fault costs in terms of performance, the tiny
>>chance that prefetching will avoid it means even the CPU usage is
>>questionable. Using sched_yield() seems like a hack though.
>>
>
>Yeah it's a hack alright. Funny how at last I find a place where yield does 
>exactly what I want and because we hate yield so much noone wants me to use 
>it all.
>
>

AFAIKS it is a hack for the same reason using it for locking is a hack,
it's just that prefetch doesn't care if it doesn't get the CPU back for
a while.

Given a yield implementation which does something completely different
for SCHED_OTHER tasks, you code may find it doesn't work so well anymore.
This is no different to the java folk using it with decent results for
locking. Just because it happened to work OK for them at the time didn't
mean it was the right thing to do.

I have always maintained that a SCHED_OTHER task calling sched_yield
is basically a bug because it is utterly undefined behaviour.

But being an in-kernel user that "knows" the implementation sort of does
the right thin, maybe you justify it that way.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
