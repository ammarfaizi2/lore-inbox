Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTKXC0p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 21:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKXC0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 21:26:45 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:48264 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262328AbTKXC0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 21:26:44 -0500
Message-ID: <3FC16C60.7040604@cyberone.com.au>
Date: Mon, 24 Nov 2003 13:26:40 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       jbarnes@sgi.com, efocht@hpce.nec.com, John Hawkes <hawkes@sgi.com>,
       wookie@osdl.org
Subject: Re: [RFC] generalise scheduling classes
References: <Pine.LNX.4.56.0311171638140.29083@earth> <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth> <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au> <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au> <3FC0A0C2.90800@cyberone.com.au> <20031124010612.GB6537@krispykreme>
In-Reply-To: <20031124010612.GB6537@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anton Blanchard wrote:

>>We still don't have an HT aware scheduler, which is unfortunate because
>>weird stuff like that looks like it will only become more common in 
>>future.
>>
>
>Yep. Look at POWER5, 2 cores on a die sharing a l2 cache and 2 threads
>on each core. On top of that you have the higher level NUMA
>characteristics of the machine. So we need SMT as well as (potentially)
>2 levels of NUMA. The overhead of enabling multi levels of NUMA may
>outweigh the gains, we need to do some analysis.
>

Technically the scheduler knows nothing about NUMA. Previously it had
local and a remote domains corresponding to inter and intra node cpu sets.
All it did was to do remote balancing a little more gently. But we'll call
it NUMA scheduling.

What you want for POWER5 is very aggressive sharing at the SMT level and
possibly even the chip level if they share l2. Less aggressive for node
local and then even less for remote.

SGI I think have differing distances between NUMA nodes and they expressed
possible interest in a multi level system.

I can't give you good benchmark numbers because I only have the NUMAQ at
OSDL to test on - its only got 2 levels anyway. I should think that
overheads are quite minor considering it is in slow paths (balancing).


