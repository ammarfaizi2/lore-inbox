Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUCBXqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUCBXqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:46:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56307 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261780AbUCBXqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:46:25 -0500
Message-ID: <40451CCA.4070907@mvista.com>
Date: Tue, 02 Mar 2004 15:46:19 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net>
In-Reply-To: <20040302230018.GL20227@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:
> 
> 
>>Hi!
>>
>>
>>>>Tom Rini wrote:
>>>>
>>>>>Hello.  The following interdiff kills kgdb_serial in favor of function
>>>>>names.  This only adds a weak function for kgdb_flush_io, and documents
>>>>>when it would need to be provided.
>>>>
>>>>It looks like you are also dumping any notion of building a kernel that can 
>>>>choose which method of communication to use for kgdb at run time.  Is this 
>>>>so?
>>>
>>>Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
>>>you try and allow for any 2 of 3 methods.
>>
>>I do not think that having kgdb_serial is so ugly. Are there any other
>>uglyness associated with that?
> 
> 
> More precisely:
> http://lkml.org/lkml/2004/2/11/224

Andrew seems to be comming from the point of view of a developer rather than a 
developer/ maintainer.

So, the counter argument is the user who is sending the thing into the field and 
wants to send just one binary kernel to all locations.  But then he needs to 
debug some problem that will work fine over the lan and later one that requires 
an early connection which the lan can not, as yet, do.  I agree that for you or 
me, this is not an issue, but what of the IT folks...

As to KGDB_MORE and KGDB_OPTIONS, they were put in for those who want to change 
the "O" option.  I feel it should NOT be changed, but I recognize that some 
folks want to reduce the optimizer distortions.  I opted for a generalized 
capability to cover all bases...

KGDB_TS is for code developers.  I invented it to give a poor mans LTT and it 
has served me well.  I am not sure we need to be able to turn it off, however.

The stack overflow thing is, I think, now in the kernel AND I have never had a 
machine behave so badly that it actually caught one.  It can go.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

