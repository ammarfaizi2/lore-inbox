Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTH1ULp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTH1ULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:11:45 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.92.226.49]:30393 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264221AbTH1UL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:11:26 -0400
Message-ID: <3F4E625A.8080002@maine.rr.com>
Date: Thu, 28 Aug 2003 16:13:14 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: nagendra_tomar@adaptec.com, Timo Sirainen <tss@iki.fi>,
       Jamie Lokier <jamie@shareable.org>, root@chaos.analogic.com,
       Martin Konold <martin.konold@erfrakon.de>, linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
References: <Pine.LNX.4.44.0308272353470.13148-100000@localhost.localdomain> <200308280842.h7S8gCln032095@turing-police.cc.vt.edu>
In-Reply-To: <200308280842.h7S8gCln032095@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Thu, 28 Aug 2003 00:12:30 +0530, Nagendra Singh Tomar said:
> 
> 
>>Why do u require file locking if there is a *single* writer ?? I don't 
>>understand why a 123 written over XXX can result in 1X3.
> 
> 
> You'd be *amazed* at what can go strange (not wrong, just strange) at the
> hardware level.  Let's assume for the sake of argument that  in your '123' and
> 'XXX', each character represents 4 or 8 or however many bytes wide your memory
> bus is (so "123" is really a 24 byte string).  The following can happen
> (especially if your hardware doesn't have cache coherency):
> 
> 1) CPU 0 stores the 24 bytes, and it splits across a cache line boundary.
> The '12' goes in one line, '3' in the next.
> 
> 2) Cache controller 0 does the writeback of '3' first.
> 
> 3) Cache controller 0 starts the writeback of the other cache line,
> and gets the '1' written, still waiting for next memory cycle to write '2'.
> 
> 4) CPU 1 or a DMA device snarfs up the 24 bytes before the '2' gets there.
> '3' got there, '1' got there, '2' will get there the *NEXT* bus cycle.
> 
> 1X3.  Whoops. 
> 
> Real hardware does this sort of thing all the time. Consider *this* gem from
> the IBM S/370 Principles of Operation (GA22-7000-10, page 5-12):
> 

Snip

 >
 >
>  In addition, if the format
> *used* to be a %4d that wrote to the last 4 bytes of a page, and somebody nails
> it to be a %8d halfway through, we may or may not get a SEGV when we scribble 4
> bytes onto the next page in memory, even if it's a readonly page we scribbled
> on....
> 

Ah, but the scribble will not take place.

> The description of what order things are seen to happen in runs for 11 pages,
> *not* including special-cases like the above....
> 

BTW you are quoting from my all time favorite book. Conceptual order is 
not always the real order and all those mind games.

Cheers,
   Dave

