Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbTLKI5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbTLKI5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:57:38 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:11735 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264240AbTLKI5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:57:37 -0500
Message-ID: <3FD8317B.4060207@cyberone.com.au>
Date: Thu, 11 Dec 2003 19:57:31 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
CC: Anton Blanchard <anton@samba.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au>
In-Reply-To: <3FD81BA4.8070602@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> Don't ask me why it runs out of steam at 150 rooms. hackbench does
> something similar. I think it might be due to some resource running
> short, or a scalability problem somewhere else.


OK, it is spinning on .text.lock.futex. The following results are
top 10 profiles from a 120 rooms run and a 150 rooms run. The 150
room run managed only 24.8% the throughput of the 120 room run.

Might this be a JVM problem?
I'm using Sun Java HotSpot(TM) Server VM (build 1.4.2_01-b06, mixed mode)

            ROOMS          120             150
PROFILES
total                   100.0%          100.0%
default_idle             81.0%           66.8%
.text.lock.rwsem          4.6%            1.3%
schedule                  1.9%            1.4%
.text.lock.futex          1.5%           19.1%
__wake_up                 1.1%            1.3%
futex_wait                0.7%            2.8%
futex_wake                0.7%            0.5%
.text.lock.dev            0.6%            0.2%
rwsem_down_read_failed    0.5%
unqueue_me                                3.2%


