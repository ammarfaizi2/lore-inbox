Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVLPNBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVLPNBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVLPNBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:01:43 -0500
Received: from smtp110.plus.mail.mud.yahoo.com ([68.142.206.243]:36254 "HELO
	smtp110.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932302AbVLPNBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:01:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6mfzOyXqNUrGNkftSUdIffetWpEQ/PI/YLy0k0gT3iOMWlNHQw1tgv9NihZD/G2i/DKx6dKkyhY6hbY/C9jj+IaISa7i/jmj7ALdqwHSFK8SgZdoeyV2bmDCUxWJlraeqBIS0eC8a0jErumQF6b0FoxNj0ySTax8iViukDMPzy0=  ;
Message-ID: <43A2BAA7.5000807@yahoo.com.au>
Date: Sat, 17 Dec 2005 00:01:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <43A21E55.3060907@yahoo.com.au>  <1134560671.2894.30.camel@laptopd505.fenrus.org> <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com>
In-Reply-To: <11202.1134730942@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>> (2) Those that have CMPXCHG or equivalent: 68020, i486+, x86_64, ia64,
>>>sparc.
>>> (3) Those that have LL/SC or equivalent: mips (some), alpha, powerpc, arm6.
>>>
>>
>>cmpxchg is basically exactly equivalent to a store-conditional, so 2 and 3
>>are the same level.
> 
> 
> No, they're not. LL/SC is more flexible than CMPXCHG because under some
> circumstances, you can get away without doing the SC, and because sometimes
> you can do one LL/SC in lieu of two CMPXCHG's because LL/SC allows you to
> retrieve the value, consider it and then modify it if you want to. With
> CMPXCHG you have to anticipate, and so you're more likely to get it wrong.
> 

I don't think that is more flexible, just different. For example with
cmpxchg you may not have to do the explicit load if you anticipate an
unlocked mutex as the fastpath.

My point is that they are of semantically equal strength.

> 
>>I don't know why you don't implement a "good" default implementation with
>>atomic_cmpxchg.
> 
> 
> Because it wouldn't be a good default.

You were proposing a worse default, which is the reason I suggested it.

> I'm thinking the best default is simply
> to wrap a counting semaphore.

Probably.

Send instant messages to your online friends http://au.messenger.yahoo.com 
