Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTIHJkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTIHJkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:40:15 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:23049 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262272AbTIHJkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:40:08 -0400
Message-ID: <3F5C5064.8070509@aitel.hist.no>
Date: Mon, 08 Sep 2003 11:48:20 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andreas Jaeger <aj@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       rth@redhat.com, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
References: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org> <ho65k76z9v.fsf@byrd.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jaeger wrote:
[...]
> The problem is that unit-at-a-time sees all functions used and finds
> some static functions/variables that are not called anywhere and
> therefore drops them, making a smaller binary.  Since GCC does not
> look into inline assembler, anything referenced from inline assembler
> only, will be treated as not used and therefore removed.
> 
> You have to options:
> - use attribute ((used)) (implemented since GCC 3.2) to tell GCC that
>   a function/variable should never be removed
> - use -fno-unit-at-a-time.
> 
> Since unit-at-a-time has better inlining heuristics the better way is
> to add the used attribute - but that takes some time.  The short-term
> solution would be to add the compiler flag,
> 
Seems to me that a better solution is to mark the assembly code
in question so gcc knows that is somehow calls the function.
That still allows optimizing away the function whenever the
assembly itself is left out. (Module not compiled or similiar)
Marking the function "used" includes it anyway.

I realize this way probably isn' supported right now,
but people are talking about changing gcc so I
mentioned it as an ideal way.

Helge Hafting


