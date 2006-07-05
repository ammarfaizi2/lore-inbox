Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWGERkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWGERkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWGERkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:40:55 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:59016 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964918AbWGERkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:40:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QSoRsmYCaj6Saw3StINxm0Cnv8XlTaguG835e4GGEoBFSnpYRxy4Wy00aDyf06LPs0f06tzwit2/nqJYX7tgLMKRoa+wk3ypRcfR/k0nVDP28lMN5obPEnXFjl37zYcLJONXqsqrHdHZIzZPW01jG73ESHclfAb5EgH52SdvaPE=  ;
Message-ID: <44ABF994.7090204@yahoo.com.au>
Date: Thu, 06 Jul 2006 03:40:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <20060705063550.GA28004@elte.hu> <44AB726B.8070602@bigpond.net.au> <20060705081934.GA1898@elte.hu>
In-Reply-To: <20060705081934.GA1898@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:

>>Of course, a comprehensive (as opposed to RT only) priority 
>>inheritance mechanism would make the "safe/unsafe to background" 
>>problem go away and make this patch very simple.  Any plans in that 
>>direction?
> 
> 
> that seems quite unlikely to happen. I think you are missing the biggest 
> issue: for RT, if the priority inheritance mechanism does not extend to 
> a given scheduling pattern it causes longer latencies, but no harm is 
> done otherwise. But for SCHED_BGND we'd have to make sure _every_ place 
> is priority-inversions safe - otherwise we risk a potential local DoS if 
> a task with a critical resource is backgrounded! That's plain impossible 
> to achieve.

Right. And it isn't just straightforward things like locks, but
any limited resource.

mempools and block device requests are two that come to mind.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
