Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVKUHqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVKUHqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVKUHqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:46:19 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:359 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751012AbVKUHqT (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 21 Nov 2005 02:46:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Qb4yOUe8Kbd4rPMzINh7EM47a8V5DUsySr07cgxoJKBl1EqvhLp+FMrXmlLXzYkt78opthRBMfzyNpBaS3kgF8FA/hRk1whZudtB+GLskvgEtKYXW0X2+5P1mV0EC7bp/R03zU7ANA5k1rFPr8pefLyCrWjBWdoJv7uWlmGw/XQ=  ;
Message-ID: <438189F0.3020004@yahoo.com.au>
Date: Mon, 21 Nov 2005 19:48:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 2.6.15-rc2] blk: request poisoning
References: <438182E7.9080809@yahoo.com.au> <20051121073357.GS25454@suse.de>
In-Reply-To: <20051121073357.GS25454@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Nov 21 2005, Nick Piggin wrote:
> 
>>This patch should make request poisoning more useful
>>and more easily extendible in the block layer.
>>
>>Don't think I have hardware that will trigger a requeue,
>>but otherwise it has been moderately tested. Comments?
> 
> 
> I like the idea, but I'm a little worried that it actually introduces
> more problems than it solves. See the mail from yesterday for instance,
> perfectly fine code but 'as' poisoning triggered.
> 
> And the merging bits already look really ugly :/
> 
> So I guess my question is, did this code ever find any driver problems?
> 

I think it found a few things here and there. Requeueing had a
couple of bugs, and I think a couple of things turned up back when
AS was a new concept to the block layer.

I think it is useful to try to enforce a coherent usage of the block
interface by drivers. For example, the IDE thing may have been a non
issue, but you might imagine some io scheduler or future accounting
(or something) in the block layer actually does need the request to
go through elv_set_request / blk_init_request.

Up to you really. I'm going to rip the code out of as-iosched.c so
I just thought it may still be useful for the block layer.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
