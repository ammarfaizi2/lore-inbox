Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTHBOxC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 10:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbTHBOxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 10:53:02 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:42594 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S265440AbTHBOw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 10:52:59 -0400
Subject: Re: volatile variable
From: Harm Verhagen <h.verhagen@chello.nl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059835979.7079.15.camel@i141046.upc-i.chello.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2003 16:52:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, 1 Aug 2003, Dinesh  Gandhewar wrote:
>
>> Hello,
>>
>> If a system call is having following code.
>>
>> add current process into wait quque ;
>> while (1)
>> {  set task state INTERRUPTIBLE ;
>>     if (a > 0)
>>       break ;
>>     schedule() ;
>> }
>> set task state RUNNING ;
>> remove current from wait queue ;
>>
>> 'a' is a global variable shared in ISR and system call
>

Dick Johnson wrote:

>In any event in your loop, variable 'a', has already been
>read by the code the compiler generates. There is nothing
>else in the loop that touches that variable. Therefore
>the compiler is free to (correctly) assume that whatever
>it was when it was first read is what it will continue to
>be. The compiler will therefore optimise it to be a single
>read and compare. So, the loop will continue forever if
>'a' started as zero because the compiler correctly knows
>that it cannot possibly change in the only execution
>path that it knows about.

This is incorrect.
If variable 'a' is a _global_ variable the compiler cannot (and will
not) assume it is
not changed in the loop. (The function call to schedule() might well
change the global, from the compiler point of view)
It will be reread every loop, even without beeing volatile.
When you have local variables that are/contain pointers to some data,
you need to mark those data fields volatie to make sure they get reread.

regards,
Harm Verhagen
-- 
Harm Verhagen <h.verhagen@chello.nl>

