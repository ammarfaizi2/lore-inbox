Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTLSLwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 06:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTLSLwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 06:52:32 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:690 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S262705AbTLSLwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 06:52:31 -0500
Message-ID: <3FE2E67A.70809@cyberone.com.au>
Date: Fri, 19 Dec 2003 22:52:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [PATCH] improve rwsem scalability (was Re: [CFT][RFC] HT scheduler)
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au> <3FD91F5D.30005@cyberone.com.au> <Pine.LNX.4.58.0312120440400.14103@devserv.devel.redhat.com> <3FDA5842.9090109@cyberone.com.au> <3FDBB261.5010208@cyberone.com.au> <3FDFE95C.9050901@cyberone.com.au>
In-Reply-To: <3FDFE95C.9050901@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Nick Piggin wrote:
>
>>
>> OK, this is an average of 5 runs at 145, 150, 155 rooms with my 
>> scheduler
>> patches, with and without my rwsem patch. Its all over the place, but 
>> I think
>> rwsem does give a small but significant improvement.
>>
>> http://www.kerneltrap.org/~npiggin/rwsem2.png
>
>
>
> What do you think? Is there any other sorts of benchmarks I should try?
> The improvement I think is significant, although volanomark is quite
> erratic and doesn't show it well.
>
> I don't see any problem with moving the wakeups out of the rwsem's 
> spinlock.
>

Actually my implementation does have a race because list_del_init isn't
atomic. Shouldn't be difficult to fix if anyone cares about it... otherwise
I won't bother.

Nick

