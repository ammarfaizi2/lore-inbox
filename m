Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTLUC4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 21:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTLUC4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 21:56:09 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:42637 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262081AbTLUC4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 21:56:06 -0500
Message-ID: <3FE50BC2.6050602@cyberone.com.au>
Date: Sun, 21 Dec 2003 13:56:02 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031221003020.6F4482C0D1@lists.samba.org>
In-Reply-To: <20031221003020.6F4482C0D1@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>In message <3FE28529.1010003@cyberone.com.au> you write:
>
>>+ * See comment for set_cpus_allowed. calling rules are different:
>>+ * the task's runqueue lock must be held, and __set_cpus_allowed
>>+ * will return with the runqueue unlocked.
>>
>
>Please, never *ever* do this.
>
>Locking is probably the hardest thing to get right, and code like this
>makes it harder.
>

Although in this case it is only one lock, and its only used in
one place, with comments. But yeah its far more complex than a
blocking semaphore would be.

>
>Fortunately, there is a simple solution coming with the hotplug CPU
>code: we need to hold the cpucontrol semaphore here anyway, against
>cpus vanishing.
>
>Perhaps we should just use that in both places.
>

We could just use a private semaphore until the hotplug code is in place.


