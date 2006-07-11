Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWGKVkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWGKVkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWGKVkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:40:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:7946 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751327AbWGKVke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:40:34 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="96466557:sNHT14905709"
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Michael S. Tsirkin'" <mst@mellanox.co.il>,
       "Zach Brown" <zach.brown@oracle.com>,
       "Hal Rosenstock" <halr@voltaire.com>,
       "Roland Dreier" <rolandd@cisco.com>
Cc: <openib-general@openib.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: ipoib lockdep warning
Date: Tue, 11 Jul 2006 14:40:32 -0700
Message-ID: <000401c6a532$a3017f50$e598070a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcalLz5MyWlBjrrVTISvPHVfTibY+AAAD5Gw
In-Reply-To: <20060711211620.GB21546@mellanox.co.il>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-OriginalArrivalTime: 11 Jul 2006 21:40:32.0914 (UTC) FILETIME=[A30D3F20:01C6A532]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Quoting r. Zach Brown <zach.brown@oracle.com>:
>> BC:
>>
>> query_idr.lock is taken with interrupts enabled and so is implicitly
>> ordered before dev->_xmit_lock which is taken in interrupt context.
>>
>> ipoib_mcast_join_task()
>>   ipoib_mcast_join()
>>     ib_sa_mcmember_rec_query()
>>       send_mad()
>>         idr_pre_get(&query_idr)
>>           spin_lock(&idp->lock)
>
>Got to check, but if that's true we have a simple deadlock here:
>ib_sa_mcmember_rec_query might get called from interrupt
>context as well, deadlocking on idp->lock?
>
>Sean?

As a side note, I believe that this is the upstream code and does not include
the latest multicast changes.

I'm not sure if anything calls into the sa_query interfaces from interrupt
context, but I doubt it.  From my brief look at the initially reported issue, I
can't determine if there's an actual problem without studying the ipoib code
more.

- Sean
