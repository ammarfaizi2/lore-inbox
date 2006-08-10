Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161333AbWHJPXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbWHJPXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWHJPXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:23:12 -0400
Received: from web25809.mail.ukl.yahoo.com ([217.12.10.194]:50297 "HELO
	web25809.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161333AbWHJPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:23:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=hw01MYvAcpAOzyy8PjQZAgdMhzCFwD80P903CdsbQJC+S6roA1hm6pjQLHjMHQ5qeXpzmKUOpkI/GB8PO4AFpEfCKCiRAFS47RT1Nzsg/3JEY3cLpT/8M/7ESMbgJjs1L1MjWhumf6U7n7l4vk3mE1e7AAYo7h7J/72nP9Funbo=  ;
Message-ID: <20060810152310.29881.qmail@web25809.mail.ukl.yahoo.com>
Date: Thu, 10 Aug 2006 15:23:10 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : sparsemem usage
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: apw@shadowen.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060811000532.b9fe3b72.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> On Thu, 10 Aug 2006 14:46:01 +0000 (GMT)
> moreau francis <francis_moreau2000@yahoo.fr> wrote:
>> Why not implementing page_exist() by simply using mem_map[] ? When
>> allocating mem_map[], we can just fill it with a special value. And
>> then when registering memory area, we clear this special value with
>> the "reserved" value. Hence for flatmem model, we can have:
>>
>> #define page_exist(pfn)        (mem_map[pfn] != SPECIAL_VALUE)
>>  
> putting a special value to a page struct at mem_map + pfn ?

yes

> 
>> and it should work for sparsemem too and other models that will use
>> mem_map[].
>>
>> Another point, is page_exist() going to replace page_valid() ?
> what is page_valid() here ? pfn_valid() (in current kernel) ?

sorry I was meaning pfn_valid() instead of page_valid() in the
whole email.

> 
>> I mean page_exist() is going to be something more accurate than
>> page_valid(). All tests on page_valid() _only_ will be fine to test
>> page_exist(). But all tests such:
>>
>>     if (page_valid(x) && page_is_ram(x))
>>
>> can be replaced by
>>
>>     if (page_exist(x))
>>
>> So, again, why not simply improving page_valid() definition rather
>> than introduce a new service ?
>>

s/page_valid/pfn_valid

> I welcome to do that if implementation is sane.
> pfn_valid() --- check there is a page struct
> page_exist() --- check there is a physical memory.
> 

new definition of pfn_valid() would be "a physical page exists". And
this definition imply the old one "it's safe to read the page struct *"

> but discussing without patch is not very good. please post your patch.
> Then we can discuss more concrete things.
> 

Since I'm not kernel hacker, or rather a newbie one, I try to make sure
that it worth to dig in that direction before working hard to write a
patch.

thanks

Francis



