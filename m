Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTCDXYT>; Tue, 4 Mar 2003 18:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTCDXYT>; Tue, 4 Mar 2003 18:24:19 -0500
Received: from fmr09.intel.com ([192.52.57.35]:45822 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id <S262201AbTCDXYR> convert rfc822-to-8bit;
	Tue, 4 Mar 2003 18:24:17 -0500
content-class: urn:content-classes:message
Subject: Re: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
Date: Tue, 4 Mar 2003 15:33:56 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA8B7DE@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLipoZHL+iRGtFHQOK6VLClIRUugw==
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <kai.bankett@ontika.net>, <mingo@redhat.com>, <akpm@diago.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 04 Mar 2003 23:33:56.0713 (UTC) FILETIME=[8666D590:01C2E2A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Kai,

  The bouncing is seen because of the round robin IRQ distribution in
some 
particular cases. In some cases, (such as single heavy interrupt source
in 
a 2way SMP system) binding heavy interrupt sources to different cpus is
not 
going to remove the complete imbalance. In that case we fall back to
Ingo's 
round robin approach. We have studied the previous round robin interrupt

distribution implemented in the kernel, and we found that, at very high 
interrupt rate, the performance of the system increased with the
increasing 
period of the round robin distribution. Please see the original LKML
posting 
for more details. 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0212.2/1122.html 

So when if there is significant imbalance left after binding the IRQs to
cpus, 
there are two options now,

  1. Do not move around. Let the significant imbalance stick on a
particular 
     cpu.

  2. Or move the heavy imbalance around all the cpus in the round robin 
     fashion at high rate.

Also we can have either of the option configurable in the kernel.

Both the solutions will eliminate the bouncing behavior. The current 
implementation is based on the option 2, with the only difference of 
lower rate of distribution (5 sec).  The optimal option is workload 
dependant. With static and heavy interrupt load, the option 2 looks 
better, while with random interrupt load the option 1 is good enough.

Thanks & Regards,
Nitin


