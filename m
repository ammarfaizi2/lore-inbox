Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTDJOjR (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTDJOjR (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:39:17 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:10959 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S264057AbTDJOjQ (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 10:39:16 -0400
Date: Thu, 10 Apr 2003 09:50:40 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix obj vma sorting
Message-ID: <21510000.1049986240@baldur.austin.ibm.com>
In-Reply-To: <208780000.1049984941@[10.10.2.4]>
References: <Pine.LNX.4.44.0304101433420.1705-100000@localhost.localdomain>
 <208780000.1049984941@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, April 10, 2003 07:29:03 -0700 "Martin J. Bligh"
<mbligh@aracnet.com> wrote:

> Yeah, sorry ... I guess someone should have published the phone
> conversation we had yesterday ... </me pokes Dave in the eye>
> 
> We came to the conclusion that should be adding the semaphore to the
> current  code even, as list_add_tail isn't atomic to a doubly linked list
> (unless maybe you can do some fancy-pants compare and exchange thing
> after setting up the prev pointer of the new element already). Which is
> probably going to suck performance-wise, but I'd prefer correctness. From
> there we can make a better judgment, but it sounds like it's going to
> content horribly on those busy semaphores. 

I didn't publish the conversation because I realized that the semaphore is
taken outside the function, so it is held.  It's what I called you back to
tell you.

I'm guessing the contention we're seeing with Hugh's fix is because of the
way ld.so works.  It maps the entire library, then does an mprotect to
change the idata section from shared to private.  It does this for every
mapped library after every exec.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

