Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWEaPeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWEaPeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWEaPeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:34:07 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:2992 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965065AbWEaPeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:34:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1PJnz7O6CZF0oZpzlW1cjr3r1V2H9hiI64VNLh/85GL7NF/NQ4OfrdTt6+7QnInNcIH8rGVYaxe7q5VfSMTTi6GopDevR3y24O0G8H6b0WUE8orKJLaWiqiSSGyLCkK3Oq0KeJiGejxl/7Rzzm3f8o9h1TeNlwPEnwhGBhInIqo=  ;
Message-ID: <447DB765.6030702@yahoo.com.au>
Date: Thu, 01 Jun 2006 01:33:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au> <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au> <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[trimming CC list]

Linus Torvalds wrote:
> 
> On Thu, 1 Jun 2006, Nick Piggin wrote:

>>
>>Example?
> 
> 
> Pretty much all of them.
> 
> Where do you wait for IO?
> 
> Would you perhaps say "wait_on_page()"?
> 
> In other words, we really _do_ exactly what you think we should do.

I still think the submitter should plug before they start a set of
requests (the submitter currently does not plug, the queue does when
it empties), and unplug when it has finished submission (not when a
process next waits, because that is suboptimal for asynch IO).

When you do this, the plug/unplug should become simple like locks too.

You're really keen on unplugging at the point of waiting. I don't get
it.

> 
> 
>>I don't know why you think this way of doing plugging is fundamentally
>>right and anything else must be wrong... it is always heuristic, isn't
>>it?
> 
> 
> A _particular_ way of doing plugging is not "fundamentally right". I'm 
> perfectly happy with chaning the place we unplug, if people want that. 
> We've done it several times.

OK.

> 
> But plugging as a _concept_ is definitely fundamentally right, exactly 
> because it allows us to have the notion of "plug + n*<random submit by 
> different paths> + unplug".

Yeah the concept isn't bad. I think the queue based implementation, and
unplug at wait time isn't great.

> 
> And you were not suggesting moving unplugging around. You were suggesting 
> removing the feature. Which is when I said "no f*cking way!".

It may be a good concept but if it doesn't help, then removing it is a good
idea too ;) Now I've been told it does help, so instead of removing it I
suggest changing it. Just exploring ideas.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
