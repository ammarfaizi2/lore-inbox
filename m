Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267607AbTBURiv>; Fri, 21 Feb 2003 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTBURiu>; Fri, 21 Feb 2003 12:38:50 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:2003 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267607AbTBURio>; Fri, 21 Feb 2003 12:38:44 -0500
Message-Id: <5.1.0.14.2.20030221094037.0d4c4ee0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 21 Feb 2003 09:44:42 -0800
To: Christoph Hellwig <hch@infradead.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030221084543.A25765@infradead.org>
References: <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com>
 <Your <5.1.0.14.2.20030220092216.0d3fefd0@mail1.qualcomm.com>
 <20030221004041.05C1F2C2D5@lists.samba.org>
 <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:45 AM 2/21/2003, Christoph Hellwig wrote:
>On Thu, Feb 20, 2003 at 05:17:52PM -0800, Max Krasnyansky wrote:
>> Yeah, I think 'try' is definitely be a misnomer in this case.
>> How about something like this ?
>> 
>> static inline void __module_get(struct module *mod)
>> {
>> #ifdef CONFIG_MODULE_DETECT_API_VIOLATION
>>         if (!module_refcount(mod))
>>                 __unsafe(mod);
>> #endif
>>         local_inc(&mod->ref[get_cpu()].count);
>>         put_cpu();
>> }
>> 
>> We will be able to compile the kernel with CONFIG_MODULE_DETECT_API_VIOLATION
>> and easily find all modules that call __module_get() without holding a reference.
>
>Drop the ifdef, add and add an unlikely instead?
Well, module_refcount() is fairly expensive (loop for NR_CPUS). So I'd keep the ifdef.

Max

