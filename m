Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSFMJmm>; Thu, 13 Jun 2002 05:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSFMJml>; Thu, 13 Jun 2002 05:42:41 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:51207 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S314325AbSFMJmk>; Thu, 13 Jun 2002 05:42:40 -0400
Message-ID: <3D086981.5030109@loewe-komp.de>
Date: Thu, 13 Jun 2002 11:44:33 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Roberto Fichera <kernel@tekno-soft.it>
CC: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: Developing multi-threading applications
In-Reply-To: <5.1.1.6.0.20020613095304.00a6fc60@mail.tekno-soft.it> <5.1.1.6.0.20020613104128.02c119a0@mail.tekno-soft.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Fichera wrote:
> At 01.26 13/06/02 -0700, you wrote:
> 
>> On Thu, 13 Jun 2002 10:13:35 +0200, Roberto Fichera wrote:
>>
>> >I'm designing a multithreding application with many threads,
>> >from ~100 to 300/400. I need to take some decisions about
>> >which threading library use, and which patch I need for the
>> >kernel to improve the scheduler performances. The machines
>> >will be a SMP Xeon with 4/8 processors with 4Gb RAM.
>> >All threads are almost computational intensive and the library
>> >need a fast interprocess comunication and syncronization
>> >because there are many sync & async threads time
>> >dependent and/or critical. I'm planning, in the future, to distribuite
>> >all the threads in a pool of SMP box.
>>
>>         With 4/8 processors, you don't want to create 100-400 threads 
>> doing
>> computation intensive tasks. So redesign things so that the number of 
>> threads
>> you create is more in line with the number of CPUs you have available. 
>> That
>> is, use a 'thread per CPU' (or slightly more threads than their are 
>> CPUs per
>> node) approach and you'll perform a lot better. Distribute the 
>> available work
>> over the available threads.
> 
> 
> You are right! But "computational intensive" is not totaly right as I 
> say ;-),
> because most of thread are waiting for I/O, after I/O are performed the
> computational intensive tasks, finished its work all the result are sent
> to thread-father, the father collect all the child's result and perform 
> some
> computational work and send its result to its father and so on with many
> thread-father controlling other child. So I think the main problem/overhead
> is thread creation and the thread's numbers.
> 

Have a look at http://www-124.ibm.com/developerworks/opensource/pthreads/

they provide M:N threading model where threads can live in userspace.


