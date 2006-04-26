Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWDZBKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWDZBKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 21:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWDZBKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 21:10:42 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:24952 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932324AbWDZBKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 21:10:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Y6ujPcNOqpAltLRdTmU+47I1p3utzxo02Eg6lEJIscHWdTAVNMZ/PxyevUTwn/rCZ1EqWBwIj7839vZXu7K/eXhviVhE0Z/K7mwAI16DKQRWE7OoHfqy9XSLak3sMvpRr1aD7DbCe5NJcvCUsj1SxJ/zRtOgMPJCP8CbUPq7RhM=  ;
Message-ID: <444EC7F9.8080208@yahoo.com.au>
Date: Wed, 26 Apr 2006 11:08:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>	 <20060424200657.0af43d6a.akpm@osdl.org>  <444DF5B4.6030004@yahoo.com.au> <1145989423.3674.17.camel@localhost.localdomain>
In-Reply-To: <1145989423.3674.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:

>On Tue, 2006-04-25 at 20:11 +1000, Nick Piggin wrote:
>
>
>>I guess it is so it can be used in NMIs and interrupts without turning
>>interrupts off (so is somewhat lightweight).
>>
>>But please Daniel, just use spinlocks and trylock. This is buggy because
>>it doesn't get the required release consistency correct.
>>
>
>
>To use spinlock we would need to used the __raw_ types . As Hua
>explained all of the vanilla spinlock calls use the unlikely macro. The
>result is that we end up using atomic operations. So using them directly
>seems like the cleanest method .
>

Ah, I see. Then you should be OK with either your current scheme, or
Andrew's suggestion, so long as you have a memory barrier before the
unlock (eg. smp_mb__before_clear_bit()).

>
>I'm not exactly sure what you mean by "release consistency" ?
>

Without a barrier, the stores to the linked list may be visible to another
CPU after the store that unlocks the atomic_t. Ie. the critical section can
leak out of the lock.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
