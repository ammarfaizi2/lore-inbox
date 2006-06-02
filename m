Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWFBCeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWFBCeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWFBCef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:34:35 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:48547 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751144AbWFBCef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:34:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sirTGgeJ54/q/QtOUf7SuLbIa3lCwppBj0ZokHXT/oEEr2/bu7GL1dH1Uhe8JPjWGKbz7V5MkQBn1By6CKO9syI8YDjbm7qNzwWUlMd0Mip02B49n6jtPLA4bBVHiwuMnle2Ytd2tEhhE54TuT3nZqgDj4WPJxBeByNigx/oX34=  ;
Message-ID: <447FA3B3.7080407@yahoo.com.au>
Date: Fri, 02 Jun 2006 12:34:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au> <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au> <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au> <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org> <447DC22C.5070503@yahoo.com.au> <447DC2CC.5060900@yahoo.com.au> <Pine.LNX.4.64.0605310940090.24646@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605310940090.24646@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 1 Jun 2006, Nick Piggin wrote:
> 
>>If this wasn't clear: I don't mean per-task plugs as in "the task
>>explicitly plugs and unplugs the block device"[*]; I mean really
>>per-task plugs.
> 
> 
> That would be insane. It would mean that you'd have to unplug whether you 

I don't think it is.

> wanted to or not. Ie you've now made "sys_readahead()" impossible to do 
> well, and doing read-ahead across multiple files.

Now it is you who are ignoring what I've been saying. I've been saying
that I don't think your sys_readahead examples have had much to do with
plugging:

1. If there are no other requests to seek to, plugging doesn't matter;
2. If there are other requests to seek to, the queue won't be plugged
    or will soon become unplugged anyway. So the current system isn't
    somehow going to do the right thing every time and be immune to
    seeking.

> 
> You're ignoring all the _reasons_ for plugging in the first place.

I'm not, but the current system of plugging isn't ideal. Anyway, there
isn't any point going on about it, if I want to change anything I at
least need to come back with numbers.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
