Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUFTKyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUFTKyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 06:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUFTKyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 06:54:46 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:21616 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265770AbUFTKyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 06:54:44 -0400
Message-ID: <40D56CF0.2040803@yahoo.com.au>
Date: Sun, 20 Jun 2004 20:54:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: page allocation failure. order:0, mode:0x20
References: <Pine.GSO.4.58.0406201115470.23356@waterleaf.sonytel.be>	 <40D565FE.1050903@yahoo.com.au> <1087727591.2805.8.camel@laptop.fenrus.com>
In-Reply-To: <1087727591.2805.8.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2004-06-20 at 12:25, Nick Piggin wrote:
> 
>>>| # free
>>>|              total       used       free     shared    buffers     cached
>>>| Mem:         10260       9844        416          0        240       5004
>>>| -/+ buffers/cache:       4600       5660
>>>| Swap:        33256       3796      29460
>>>
>>
>>Not even atomic allocations memory are allowed to consume all memory.
>>A small amount is reserved for memory freeing (which sometimes
>>requires initial memory allocations).
>>
>>The message should be harmless.
> 
> 
> Since atomic allocations by definition need to be able to cope with
> failure, how about a patch like this to not warn for this common and
> legit case?
> 

CC'ed Andrew: I think it's his baby.

I guess we're at the point where we should quiet down things like
this. Although order-0 atomic allocation failures are pretty rare,
I'd consider leaving them in. Maybe a CONFIG option?
