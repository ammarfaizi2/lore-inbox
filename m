Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWGTMK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWGTMK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 08:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWGTMK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 08:10:29 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:33511 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1030298AbWGTMK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 08:10:28 -0400
In-Reply-To: <20060720060736.GA25367@stusta.de>
References: <20060718091807.467468000@sous-sol.org> <20060718091950.750213000@sous-sol.org> <20060720060736.GA25367@stusta.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e4182acc9b5779fedf8f5b003126673c@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Ian Pratt <ian.pratt@xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 09/33] Add start-of-day setup hooks to subarch
Date: Thu, 20 Jul 2006 13:10:11 +0100
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Jul 2006, at 07:07, Adrian Bunk wrote:

>> +struct start_info *xen_start_info;
>> +EXPORT_SYMBOL(xen_start_info);
>
> EXPORT_SYMBOL_GPL?

Possibly.

>> +/*
>> + * Point at the empty zero page to start with. We map the real 
>> shared_info
>> + * page as soon as fixmap is up and running.
>> + */
>> +struct shared_info *HYPERVISOR_shared_info = (struct shared_info 
>> *)empty_zero_page;
>> +EXPORT_SYMBOL(HYPERVISOR_shared_info);
>> ...
>
> EXPORT_SYMBOL_GPL?

Interrupt-control macros (local_irq_enable/disable and friends) used 
this symbol, so GPLing it made non-GPL modules fail. We made a bunch of 
the macros proper functions so this may no longer be the case.

  -- Keir

