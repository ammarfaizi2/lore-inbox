Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVCUXQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVCUXQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVCUXL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:11:58 -0500
Received: from spectre.fbab.net ([212.214.165.139]:51587 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S262203AbVCUXKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:10:17 -0500
Message-ID: <423F5456.5010908@fbab.net>
Date: Tue, 22 Mar 2005 00:10:14 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu>
In-Reply-To: <20050321090622.GA8430@elte.hu>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> i've uploaded my current tree (-V0.7.41-01) to:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> it includes the latest round of RCU fixes - but doesnt solve the SMP
> bootup crash.
> 
> 	Ingo

With this kernel I can run for some 20 minutes, then the ip_dst_cache 
overflows.
I gather it has something to do with RCU...

If I just let it run and grep ip_dst_cache /proc/slab it goes up to 4096 
(max) and then the printk's are starting, and the networks stops.
After i up the limit to the double (echo "8192" > 
/proc/sys/net/ipv4/route/max_size) network starts to work again.
But of course, after a while it overflows again:

# grep ip_dst_cache /proc/slabinfo
ip_dst_cache        8192   8205    256   15    1 : tunables   16    8 
  0 : slabdata    547    547      0

I haven't tried the vanilla 2.6.12-rc2 kernel, and I don't have the time 
to do that right now, but i figured it would have something to do with 
your patch. Older 2.6.8 works just fine.

Regards,
Magnus
