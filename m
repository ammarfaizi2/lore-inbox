Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275061AbTHQHGU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 03:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275060AbTHQHGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 03:06:20 -0400
Received: from dyn-ctb-210-9-245-67.webone.com.au ([210.9.245.67]:25094 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275061AbTHQHGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 03:06:18 -0400
Message-ID: <3F3F293E.7010303@cyberone.com.au>
Date: Sun, 17 Aug 2003 17:05:34 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
References: <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <20030817065501.GA1105@mail.jlokier.co.uk>
In-Reply-To: <20030817065501.GA1105@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:

>Mike Galbraith wrote:
>
>>>The point of the mechanism is to submit system calls in an
>>>asynchronous fashion, after all.  A proper task scheduling is
>>>inappropriate when all we'd like to do is initiate the syscall and
>>>continue processing, just as if it were an async I/O request.
>>>
>>Ok, so you'd want a class where you could register an "exception handler" 
>>prior to submitting a system call, and any subsequent schedule would be 
>>treated as an exception?  (they'd have to be nestable exceptions too 
>>right?... <imagines stack explosions> egad:)
>>
>
>Well, apart from not resembling exceptions, and no they don't nest :)
>

Is it clear that this is a win over having a regular thread to
perform the system call for you? Its obviously a lot more complicated.

I _think_ what you describe is almost exactly what KSE or scheduler
activations in FreeBSD 5 does. I haven't yet seen a test where they
significantly beat regular threads. Although I'm not sure if FreeBSD
uses them for asynchronous syscalls, or just user-space thread
scheduling.


