Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWGKQ3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWGKQ3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWGKQ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:29:21 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:55903 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751089AbWGKQ3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:29:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CsxYcSpVSHOu8yqxOr7I6TdGPoV8HRrD4VZiEMVGD3hGK/wEdFdZ7N+NMrtF226vQsQntoyfGXXZue1qcRVDg5r1qOh8K0UZx7a53BeHDyQAOoGQFePO+XXKXp9TYDvv7D7gdKRlaZfvfWr+FsTrrFHgfRDUc+mPDYHBa2ffI+E=  ;
Message-ID: <44B379F6.4070309@yahoo.com.au>
Date: Tue, 11 Jul 2006 20:14:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] Consolidate the request merging
References: <20060711090838.GU5210@suse.de>
In-Reply-To: <20060711090838.GU5210@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> Right now, every IO scheduler implements its own backmerging (except for
> noop, which does no merging). That results in duplicated code for
> essentially the same operation, which is never a good thing. This patch
> moves the backmerging out of the io schedulers and into the elevator
> core. We save 1.6kb of text and as a bonus get backmerging for noop as
> well. Win-win!
> 
> Notes:
> 
> - I dropped the "move hot entries to front" logic. It's never been
>   proven good, and some research indicates that it's a bad idea. I doubt
>   it matters in real life, so lets just cut that away.
> 
> - Next it might be a good idea to move the rb sorting into the elevator
>   core as well. We could save some more kernel text, but more
>   importantly it gets us one step closer to dropping deadline_rq from
>   the deadline scheduler.

Seems like a good idea. I don't think this could be a downside for anyone
except maybe Ken Chen, if it adds any overhead to the noop scheduler.

BTW, IMO it is a good idea for the noop scheduler to do as much merging as
possible, especially as it could be used for things like network block
devices (but more merging may actually cut down on CPU and IO bandwidth
even in the local disk case).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
