Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUCJOZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbUCJOZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:25:50 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:32661 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262618AbUCJOZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:25:49 -0500
Message-ID: <404F2545.40708@softhome.net>
Date: Wed, 10 Mar 2004 15:25:09 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaco Kroon <jkroon@cs.up.ac.za>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stack allocation and gcc
References: <404F09C6.7030200@softhome.net> <404F104C.2030206@cs.up.ac.za>
In-Reply-To: <404F104C.2030206@cs.up.ac.za>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaco Kroon wrote:
> Hi Ihar,
> 
> In your code you have 3 buffers, one in the mani branch of 32 bytes and 
> one of 32 bytes in each of the sub branches.  This adds up to a total of 
> 64 bytes since as you say, the two buffers named buf2[32] can be 
> shared.  Thus it is 32 bytes for buf and 32 bytes for the shared 
> buffer.  Now if you look at the function startup code:
> 
>   0:   55                      push   %ebp
>   1:   89 e5                   mov    %esp,%ebp
>   3:   83 ec 68                sub    $0x68,%esp
> 
> THe push saves the frame pointer (ebp).  The mov sets up the new stack 
> frame and the sub allocates space of 68 bytes on the stack, 4 bytes more 
> than the expected 64, this is probably for temporary storage required 
> somewhere in the function.  As such, gcc does not allocate 32 bytes too 
> many (at least not on i386, but probably not on other architectures 
> either).
> 
> Jaco
> 

   0x68 != 68.

   [ All known to me assemblers on ix86 use hexadecimal number by 
default. I was sort of surprised to find out that ppc gas uses decimal 
numbers only. ]

   0x68 == 104 == 32*3 + 4 + 4.

   As I have said, keep adding to function 'do { char buf[32]; 
printf(buf); } while(0)' increse this number. As in my logic it is 
supposed to be unchanged - all renundant buffers do have same size - 32 
bytes.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|
