Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUATIQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUATIQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:16:05 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:5274 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265193AbUATIQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:16:01 -0500
Message-ID: <400CE354.8060300@cyberone.com.au>
Date: Tue, 20 Jan 2004 19:14:12 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Rusty Russell <rusty@au1.ibm.com>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org>
In-Reply-To: <20040120075409.GA13897@hockin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Hockin wrote:

>On Tue, Jan 20, 2004 at 06:45:37PM +1100, Nick Piggin wrote:
>
>>>I guess a hotplug script MAY fail.  I don't think it's a good idea to make
>>>your CPU hotplug script fail.  May and Misght are different.  It's up to 
>>>the
>>>implementor whether the script can get into a failure condition.
>>>
>>>
>>Sorry bad wording. The script may fail to be executed.
>>
>
>Under what conditions?  Not arbitrary entropy, surely.  If a hotplug script
>is present and does not blow up, it should be safe to assume it will be run
>upon an event being delivered.  If not, we have a WAY bigger problem :)
>

That assumption is not safe. The main problems are of course process limits
and memory allocation failure.

>
>>>What if <which> process needs guaranteed scheduling latency?  Do we really
>>>_guarantee_ scheduling latency *anywhere*?
>>>
>>We do guarantee that a realtime task won't be blocked waiting for
>>a hotplug script to fault in and start it up again (which may not
>>happen). Not sure how important this issue is.
>>
>
>We have a conflict of priority here.  If an RT task is affined to CPU A and
>CPU A gets yanked out, what do we do?
>
>Obviously the RT task can't keep running as it was.  It was affined to A.
>Maybe for a good reason.  I see we have a few choices here:
>
>* re-affine it automatically, thereby silently undoing the explicit
>  affinity.
>* violate it's RT scheduling by not running it until it has been re-affined
>  or CPU A returns to the pool/
>
>Sending it a SIGPWR means you have to run it on a different CPU that it was
>affined to, which is already a violation.
>

At least the task has the option to handle the problem.


