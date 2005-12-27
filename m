Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVL0AdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVL0AdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 19:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVL0AdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 19:33:12 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:13481 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932167AbVL0AdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 19:33:12 -0500
Date: Mon, 26 Dec 2005 16:32:33 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Andrew Morton <akpm@osdl.org>
cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       zippel@linux-m68k.org, hch@infradead.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-Reply-To: <20051226031128.13bbace9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0512261629490.20117@qynat.qvtvafvgr.pbz>
References: <20051222114147.GA18878@elte.hu><20051222153014.22f07e60.akpm@osdl.org><20051222233416.GA14182@infradead.org><200512251708.16483.zippel@linux-m68k.org><20051225150445.0eae9dd7.akpm@osdl.org><20051225232222.GA11828@elte.hu><20051226023549.f46add77.akpm@osdl.org><1135593776.2935.5.camel@laptopd505.fenrus.org>
 <20051226031128.13bbace9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005, Andrew Morton wrote:

> Arjan van de Ven <arjan@infradead.org> wrote:
>>
>>
>>> hm.  16 CPUs hitting the same semaphore at great arrival rates.  The cost
>>> of a short spin is much less than the cost of a sleep/wakeup.  The machine
>>> was doing 100,000 - 200,000 context switches per second.
>>
>> interesting.. this might be a good indication that a "spin a bit first"
>> mutex slowpath for some locks might be worth implementing...
>
> If we see a workload which is triggering such high context switch rates,
> maybe.  But I don't think we've seen any such for a long time.
>

how does 'spin a bit' interact with virutal CPU's (HT and equivalent).

it would seem to me that on a multi true-core system the spin-a-bit is a 
win becouse it allows the other CPU's to release the lock, but on virtual 
CPU's all the spinning would do is to delay the other virtual CPU's 
running and therefor delay the lock getting released.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

