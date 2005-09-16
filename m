Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbVIPIy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbVIPIy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbVIPIy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:54:57 -0400
Received: from fmr18.intel.com ([134.134.136.17]:42217 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161138AbVIPIy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:54:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: A question about sceduling
Date: Fri, 16 Sep 2005 16:54:53 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8403532D39@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: A question about sceduling
Thread-Index: AcW6jnwhyMZJKdWfQCS4VlScZPAYRQADZEow
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Roy Lee" <roylee17@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Sep 2005 08:54:55.0247 (UTC) FILETIME=[4EF809F0:01C5BA9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Roy Lee
>>Sent: 2005Äê9ÔÂ16ÈÕ 15:16
>>To: linux-kernel@vger.kernel.org
>>Subject: A question about sceduling
>>
>>I'm tracing the scheduling code of 2.6.12.
>>During the process creation, the parent process would let the child process
>>execute first to avoid the COW overhead.
>>
>>In wake_up_new_task():
>>
>>                   if (!(clone_flags & CLONE_VM)) {
>>            /*
>>             * The VM isn't cloned, so we're in a good position to
>>             * do child-runs-first in anticipation of an exec. This
>>             * usually avoids a lot of COW overhead.
>>             */
>>            if (unlikely(!current->array))
>>                __activate_task(p, rq);
>>            else {
>>                p->prio = current->prio;
>>                list_add_tail(&p->run_list, &current->run_list);
>>                p->array = current->array;
>>                p->array->nr_active++;
>>                rq->nr_running++;
>>            }
>>            set_need_resched();
>>
>>It sets the flag to notify the kernel to reschedule.
>>But, the child has the same priority as it's parent and is the at the "tail"
>>of that priority queue.
list_add_tail(&p->run_list, &current->run_list) means insert the child into run list before parent (current)., not the tail of that priority queue.

