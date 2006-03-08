Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWCHIwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWCHIwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWCHIwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:52:22 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:37493 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932518AbWCHIwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:52:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BFTLnBH3g4N5qLXxqXSKbkZEDW7p+B6Jhd1rjvgL7iWqhhs9jwzah4rjb2fGAHH+sOxHVCcFnAmbAzkHq/HzDzwortEM9PqS3f+0LtmYdj5pocqf2/NlIPZFhr6wVfzXB5HMuTEh9Q9Mp48KI9TLfxfqwKF+c1juv4LFVeWQ+18=  ;
Message-ID: <440E9B41.9020708@yahoo.com.au>
Date: Wed, 08 Mar 2006 19:52:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benjamin LaHaise <bcrl@kvack.org>, mingo@elte.hu,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [patch] i386 spinlocks: disable interrupts only if we enabled
 them
References: <200603071837_MC3-1-BA13-E5FB@compuserve.com>	<20060307161550.27941df5.akpm@osdl.org>	<20060308004308.GA16069@elte.hu>	<20060308025227.GP5410@kvack.org> <20060307225556.75cee661.akpm@osdl.org>
In-Reply-To: <20060307225556.75cee661.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Benjamin LaHaise <bcrl@kvack.org> wrote:
> 
>>On Wed, Mar 08, 2006 at 01:43:08AM +0100, Ingo Molnar wrote:
>> > we dont inline that code anymore. So i think the optimization is fine.
>>
>> Why is that?  It adds memory traffic that has to be synchronized 
>> before the lock occurs and clobbered registers now in the caller.
> 
> 
> Is the inlined lock;decb+jns likely to worsen the text size?  I doubt it. 
> Overall text will get bigger due to the out-of-line stuff, but that's OK.
> 
> I'm sure we went over all this, but I don't recall the thinking.

Seems like a very good idea not to clobber any registers in
lock fastpaths. I don't see how that could have been a win
(especially for i386) but still, Ingo must have had a reason
behind it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
