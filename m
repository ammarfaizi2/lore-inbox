Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVKEB10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVKEB10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVKEB10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:27:26 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:40041 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751429AbVKEB10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:27:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=km1botnh3crnzNk9xgRboLoUiDQAEXT0GoAuam9VgPlFLCrlYHIWcvb0xrrUmrvyU9QFTC9HnSgRL/KaA865wk4sBAbHdkJy/SKmo2K9WTDwFI9n+jORXD1CQexDusbxO5TeRUxn9OyK0iDfhrHQEp9wM/xzOWBvXcNOiL1i6To=  ;
Message-ID: <436C0AFB.4050102@yahoo.com.au>
Date: Sat, 05 Nov 2005 12:29:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: ntl@pobox.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] big reader semaphore take#2
References: <20051028104437.GA17461@htj.dyndns.org> <436B79BA.6070300@gmail.com> <436BF961.9070402@yahoo.com.au> <436C0859.6050806@gmail.com>
In-Reply-To: <436C0859.6050806@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Nick Piggin wrote:

>> The upshot of that would be that you could build the whole thing
>> from rwsem infrastructure and have basically zero other locking
>> mechanisms or complexity that you don't want in a synchronisation
>> primitive.
>>
> 
> To certain extent, I do agree with you - it's safer/simpler..., but on 
> the other hand, new brsem isn't that more complex and would perform 
> almost identically without extra semantical baggage.  So, I thought it 
> might be worth a bit more effort.
> 

I would do it thisway if possible, yes.

> Hmm... So, array of rwsem's, it should be.
> 

First implementation would be per-cpu just rwsems. A second patch
to make it just an array rwsem->count's plus a shared queue may
be in order - OTOH everyone does their own rwsems, so this will be
a bit of a headache.

I forget - are you just planning to use one global brsem? In this
case the size issue wouldn't be a pressing one.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
