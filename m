Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUCZDzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbUCZDzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:55:31 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:32913 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263927AbUCZDzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:55:22 -0500
Message-ID: <4063A217.30807@yahoo.com.au>
Date: Fri, 26 Mar 2004 14:23:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de>
In-Reply-To: <20040325154011.GB30175@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Mar 25, 2004 at 07:31:37AM -0800, Nakajima, Jun wrote:
> 
>>Andi,
>>
>>Can you be more specific with "it doesn't load balance threads
>>aggressively enough"? Or what behavior of the base NUMA scheduler is
>>missing in the sched-domain scheduler especially for NUMA?
> 
> 
> It doesn't do load balance in wake_up_forked_process()  and is relatively
> non aggressive in balancing later. This leads to the multithreaded OpenMP
> STREAM running its childs first on the same node as the original process
> and allocating memory there. Then later they run on a different node when
> the balancing finally happens, but generate  cross traffic to the old node, 
> instead of using the memory bandwidth of their local nodes.
> 
> The difference is very visible, even the 4 thread STREAM only sees the
> bandwidth of a single node. With a more aggressive scheduler you get
> 4 times as much.
> 
> Admittedly it's a bit of a stupid benchmark, but seems to representative
> for a lot of HPC codes.

Hi Andi,
Sorry I keep telling you I'll work on this, but I never get
around to it. Mostly lack of hardware makes it difficult. I've
fixed a few bugs and some other workloads, so I keep hoping
that they will fix your problem :P

Your STREAM performance is really bad and I hope you don't
think I'm going to ignore it even if it is a bit stupid. Give
me a bit more time.

Of course, there is nothing fundamentally wrong with
sched-domains that is causing your problem. It can easily do
anything the old numa scheduler can do. It must be a bug or
some bad tuning somewhere.

Nick
