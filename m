Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270976AbTHBBtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 21:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270978AbTHBBtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 21:49:36 -0400
Received: from dyn-ctb-203-221-72-184.webone.com.au ([203.221.72.184]:32004
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S270976AbTHBBtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 21:49:33 -0400
Message-ID: <3F2B18A4.6010407@cyberone.com.au>
Date: Sat, 02 Aug 2003 11:49:24 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
References: <1059697921.30747.54.camel@big.pomac.com>	 <3F2A0863.5070806@cyberone.com.au> <1059740304.5285.60.camel@big.pomac.com>
In-Reply-To: <1059740304.5285.60.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kumlien wrote:

>On Fri, 2003-08-01 at 08:27, Nick Piggin wrote:
>
>>Ian Kumlien wrote:
>>
>>
>>>Hi all,
>>>
>>>I have been following the sheduler and interactivity discussions closely
>>>but via the marc.theaimsgroup.com archive, So i might be behind etc...
>>>=P
>>>
>>>[Note: sorry if i sound like mr.know-it-all etc, just trying to get a
>>>point across]
>>>
>>>Anyways, i think that the AS discussions that i have seen has missed
>>>some points. Getting the processes priority in AS is one thing, but fist
>>>of all i think there should be a stand off layer. Let me explain:
>>>
>>>I liked Jens Axobe's 'CBQ' alike implementation (based on the idea of
>>>Andrea A. (afair i have the names right) since it does the most
>>>important thing... which is *nothing* when there is no load (ie, pass
>>>trough).
>>>
>>>AS might be/is the best damn io sheduler for loaded machines but when
>>>there is no load, it's overhead. So in my opinion there should be
>>>something that first warrants the usage of AS before it's actually
>>>engaged.
>>>
>>>And, if it's only engaged during high load, additions like basing the
>>>requests priority on the process/tasks priority would make total sense,
>>>adding the 'wakeup on wait' or what it was would also make total
>>>sense... But how many of your machines uses the disk 100% of the time?
>>>(in the real world... )
>>>
>>>I don't know how 'CBQ' was implemented but any 'we are under load now'
>>>trigger would do it for me.
>>>
>>>Please see to it that my CC is included in any discussions =)
>>>
>>>PS. Or was it a version of SFQ? in that case s/CBQ/SFQ/g
>>>
>>>
>>To start with its CFQ. Also could you clarify what you mean by
>>load and what you mean by CFQ doing nothing, and why AS is overhead
>>in the no load case. I can't really follow what you are saying.
>>
>
>CFQ passes the req's on directly until there is enough load... In the
>load case it builds queues. Just like SFQ (but sfq can drop packets
>afair).
>

What do you mean? CFQ merges and sorts requests, and it services
each process in a round robin manner. I don't have the CFQ code
at hand, but I don't think it does anything different in the
"load" case.

>
>This way, we wouldn't have the initial
>'can-we-merge-this-with-other-data-coming' delay when not needed.
>

No that is what queue plugging can be used for.

>
>If as could be attached to the 'queue build up' then AS would only be
>doing what it's good at, throughput and minimizing head movements.
>

No, AS does only try to do what it is good at. As complex as it
is, its meant to be almost as simple as possible.

>
>Also patches that move prioritized data (data for processes with high
>pri) would fit right in there since you'd only be doing it during actual
>load.
>
>(note: load as in disk load)
>

I'm sorry but I'm having trouble working out what you are trying to say.
The disk gets its work in the form of a request. Linux keeps a queue of
outstanding requests for each disk. The IO schedulers are a layer between
the disk (driver) and the request queue. They get to choose the next
request that goes to the disk. AS is only set apart because it sometimes
chooses not to send a request at all even if there are some available.

Now what do you mean by disk load? And actual load? I can imagine that
if there are no requests you would say there is no load on the disk. If
there is 1 request there must be some actual load? Maybe you mean more
than 1 process with outstanding requests?

