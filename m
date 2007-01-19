Return-Path: <linux-kernel-owner+w=401wt.eu-S932842AbXASTBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbXASTBa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbXASTBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:01:30 -0500
Received: from chicken.visionpro.com ([63.91.95.13]:45375 "EHLO
	chicken.machinevisionproducts.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932842AbXASTB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:01:29 -0500
X-Ninja-PIM: Scanned by Ninja
X-Ninja-AttachmentFiltering: (no action)
User-Agent: Microsoft-Entourage/11.3.3.061214
Date: Fri, 19 Jan 2007 11:01:27 -0800
Subject: Re: Threading...
From: Brian McGrew <brian@visionpro.com>
To: Arjan van de Ven <arjan@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <fedora-users@rdhat.com>
Message-ID: <C1D65587.16E59%brian@visionpro.com>
Thread-Topic: Threading...
Thread-Index: Acc7/DiOdxDFtqfvEdu+HwADk9KF+g==
In-Reply-To: <1169232941.3055.555.camel@laptopd505.fenrus.org>
Mime-version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07 10:55 AM, "Arjan van de Ven" <arjan@infradead.org> wrote:
> On Fri, 2007-01-19 at 10:43 -0800, Brian McGrew wrote:
>> I have a very interesting question about something that we're seeing
>> happening with threading between Fedora Core 3 and Fedora Core 5.  Running
>> on Dell PowerEdge 1800 Hardware with a Xeon processor with hyper-threading
>> turned on.  Both systems are using a 2.6.16.16 kernel (MVP al la special).
>> 
>> We have a multithreaded application that starts two worker threads.  On
>> Fedora Core 3 both of these we use getpid() to get the PID of the thread and
>> then use set_afinity to assign each thread to it's own CPU.  Both threads
>> run almost symmetrically even on their given CPU watching the system
>> monitor.
> 
> this is odd; even in FC3 getpid() is supposed to return the process ID
> not the thread ID
> 
>> What am I missing?  What do I need to do in FC5 or the kernel or the
>> threading library to get my threads to run in symmetric parallel again???
> 
> you should fix the app to use something like pthread_self() instead...
> (or the highly unportable gettid() but that would just be horrible)
-----

And on FC5 I am using pthread_self but my problem isn't simply with
pthread_self, it's with the scheduling.  On FC3 both threads run
simultaneously in almost symmetric parallel.  On FC5 one thread don't pick
up and start until the previous one is done.  On FC3, using getpid for the
thread I could use set_afinity to force each thread to its own processor and
with FC5 I can't; so I've got one idle processor all the time.

-brian

Brian McGrew    { brian@visionpro.com || brian@doubledimension.com }
--
> Do not read this email while waxing that cat!

