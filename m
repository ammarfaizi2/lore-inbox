Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUDOXO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUDOXO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:14:57 -0400
Received: from CPE-203-51-35-15.nsw.bigpond.net.au ([203.51.35.15]:23537 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261187AbUDOXOz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:14:55 -0400
Message-ID: <407F1769.9090700@eyal.emu.id.au>
Date: Fri, 16 Apr 2004 09:14:49 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.26-rc2
References: <20040406004251.GA24918@logos.cnet> <4078E3BA.8040707@eyal.emu.id.au> <20040414121231.GA1406@logos.cnet>
In-Reply-To: <20040414121231.GA1406@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> The void pointer case in here its being done math on without any problem. What is the
> problem with void pointer math 

There is a problem regarding the C standard. The semantics of 'void *' are well defined
and only allow for limited use. Basically, you can cast any pointer to and from 'void *',
but nothing else.

Pointer math says that 'p+n' means "add to 'p' the value 'n*s' where 's' is the size
on the element that 'p' points to". A 'void *' does not have a defined element size
until it is cast. So, ANSI specifically does not allow any arithmetics on 'void *'.

Some compilers are forgiving and will invent an element size of '1' and allow the
math. We should not rely on such improper usage.

>> Maybe a cast is
>>called for in bh_kmap(), like:
>>	return (char *)kmap(bh->b_page) + bh_offset(bh);
> 
> 
> Hum, that would fix the warning but I dont see much reasoning behind it. 

It will not simply 'fix' the problem, this is one case where a cast is not
a bad thing (i.e. a cheat) but the correct thing to do.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
