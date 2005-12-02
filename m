Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbVLBKgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVLBKgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 05:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVLBKgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 05:36:38 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:64480 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932719AbVLBKgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 05:36:38 -0500
Message-ID: <439023A3.4090201@cosmosbay.com>
Date: Fri, 02 Dec 2005 11:36:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       ak@suse.de, discuss@x86-64.org, shai@scalex86.org,
       rusty@rustcorp.com.au
Subject: [RFC] NUMA aware kthread_create() ?
References: <20051202081028.GA5312@localhost.localdomain>	<20051202082309.GC5312@localhost.localdomain> <20051202010548.4da3d1bb.akpm@osdl.org>
In-Reply-To: <20051202010548.4da3d1bb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 02 Dec 2005 11:36:17 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is there any plans about making a kthread_create_on_cpu() version of 
kthread_create(), so that memory allocated for thread stack/info is allocated 
on the node of the target CPU ?

There is a mention about kthread_create_on_cpu() in a comment in 
include/linux/kthread.h, but no implementation.

The current use pattern is

p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
if (IS_ERR(p)) { error ... }
kthread_bind(p, hotcpu);

So the thread memory is currently allocated on the node of the current cpu, ie 
not the target cpu (hotcpu in this example)

Thank you
Eric Dumazet
