Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbTDJOqF (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTDJOqF (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:46:05 -0400
Received: from franka.aracnet.com ([216.99.193.44]:39847 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264076AbTDJOqE (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 10:46:04 -0400
Date: Thu, 10 Apr 2003 07:57:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave McCracken <dmccr@us.ibm.com>, Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix obj vma sorting
Message-ID: <211120000.1049986657@[10.10.2.4]>
In-Reply-To: <21510000.1049986240@baldur.austin.ibm.com>
References: <Pine.LNX.4.44.0304101433420.1705-100000@localhost.localdomain><208780000.1049984941@[10.10.2.4]> <21510000.1049986240@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yeah, sorry ... I guess someone should have published the phone
>> conversation we had yesterday ... </me pokes Dave in the eye>
>> 
>> We came to the conclusion that should be adding the semaphore to the
>> current  code even, as list_add_tail isn't atomic to a doubly linked list
>> (unless maybe you can do some fancy-pants compare and exchange thing
>> after setting up the prev pointer of the new element already). Which is
>> probably going to suck performance-wise, but I'd prefer correctness. From
>> there we can make a better judgment, but it sounds like it's going to
>> content horribly on those busy semaphores. 
> 
> I didn't publish the conversation because I realized that the semaphore is
> taken outside the function, so it is held.  It's what I called you back to
> tell you.

Oh yeah. I guess I should poke myself in the eye instead ;-)
So it's OK the way it is.
 
> I'm guessing the contention we're seeing with Hugh's fix is because of the
> way ld.so works.  It maps the entire library, then does an mprotect to
> change the idata section from shared to private.  It does this for every
> mapped library after every exec.

Eeek. There's no way we can set this up to do it as two separate VMAs
initially, is there?

M.

