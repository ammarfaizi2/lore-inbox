Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTILU3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTILU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:29:08 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:47626 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261861AbTILU3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:29:03 -0400
Message-ID: <3F6231D7.6040702@techsource.com>
Date: Fri, 12 Sep 2003 16:51:35 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: James Clark <jimwclark@ntlworld.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com> <Pine.LNX.4.53.0309041723090.9557@chaos> <3F5F8E90.4020701@techsource.com> <Pine.LNX.4.53.0309101640550.18999@chaos>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:
> On Wed, 10 Sep 2003, Timothy Miller wrote:
> 
> 
>>I just have one quick question about all of this:
>>
>>People mention that driver interfaces don't change much in stable
>>releases, but if memory serves, symbol versioning information changes
>>with each minor release, requiring a recompile of modules.
>>
>>Would it be possible to have a driver module which can be dropped into,
>>say, 2.6.17 that can also be dropped into 2.6.18 as long as the
>>interface doesn't change?
>>
> 
> 
> Short answer, YES. Anything that can be done is possible. The
> problem is that different kernel versions end up with different
> structure members, etc. So, you can't use code for 2.2.xxx in
> 2.4.xx because, amongst other things, the first element in
> 'struct file_operations' was added and the others moved up.

That's all fine and dandy.  When the kernel changes its interface, then 
you have to recompile (or rewrite) drivers.  No problem.  I'm just 
trying to avoid having to recompile drivers if the interface DOESN'T change.

> 
> Now, you can make a different module interface that maintains
> a compatibility level ABI. This has been discussed. Unfortunately,
> this adds code in the execution path. This extra code gets
> executed every time the module code is accessed. The result being
> that the module can't possibly operate as fast as it would if
> there were no such compatibility layer(s). It might be "good enough",
> but it is unlikely that the module contributors/maintainers would
> allow such an interface because the loss of performance is measurable
> and there has been no requirement to trade-off performance for
> anything (your and my convenience doesn't count, those are not
> technical issues).

I am not interested in adding additional layers of abstraction.  At 
least not here.  I do it plenty of other places, but that's not 
important right now.  If someone else wants to make an abstraction layer 
(which seems to have been done here and there), then that's just fine, 
and I may or may not use it.

My point is that I'm not advocating any of the kruft associated with 
backward-compatible interfaces.  I'm advocating not having to recompile 
only in the cases where the interface DOES NOT change.

Why?  Because there are some advantages to being able to say that this 
one module can be dropped into any box running, for instance, 2.6.12 
through 2.6.16, while the next module is used for 2.6.17 thru 2.6.22, etc.

For distributions, this can be helpful for drivers which are not in the 
mainline kernel.  So, I'm not trying to necessarily find a way to help 
binary-only drivers (although it would, to some extent).

