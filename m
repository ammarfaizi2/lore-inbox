Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVCTGh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVCTGh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVCTGh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:37:27 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:733 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261564AbVCTGhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:37:22 -0500
Message-ID: <423D19FE.7020902@colorfullife.com>
Date: Sun, 20 Mar 2005 07:36:46 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
References: <20050318002026.GA2693@us.ibm.com> <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu> <423BB299.4010906@colorfullife.com> <20050319162601.GA28958@elte.hu>
In-Reply-To: <20050319162601.GA28958@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>which precise locking situation do you mean?
>
>  
>
cpu 1:
acquire random networking spin_lock_bh()

cpu 2:
read_lock(&tasklist_lock) from process context
interrupt. softirq. within softirq: try to acquire the networking lock.
* spins.

cpu 1:
hardware interrupt
within hw interrupt: signal delivery. tries to acquire tasklist_lock.

--> deadlock.

--
    Manfred
