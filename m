Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTCEE2E>; Tue, 4 Mar 2003 23:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTCEE2D>; Tue, 4 Mar 2003 23:28:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267091AbTCEE2B>;
	Tue, 4 Mar 2003 23:28:01 -0500
Message-ID: <3E657F33.4000304@pobox.com>
Date: Tue, 04 Mar 2003 23:38:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       kai.bankett@ontika.net, mingo@redhat.com,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
References: <E88224AA79D2744187E7854CA8D9131DA8B7E0@fmsmsx407.fm.intel.com>
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA8B7E0@fmsmsx407.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kamble, Nitin A wrote:
> There are few issues we found with the user level daemon approach.

Thanks much for the response!


>    Static binding compatibility: With the user level daemon, users can
> not  
> use the /proc/irq/i/smp_affinity interface for the static binding of
> interrupts.

Not terribly accurate:  in "one-shot" mode, where the daemon balances 
irqs once at startup, users can change smp_affinity all they want.

In the normal continuous-balance mode, it is quite easy to have the 
daemon either (a) notice changes users make or (b) configure the daemon. 
  The daemon does not do (a) or (b) currently, but it is a simple change.


>   There is some information which is only available in the kernel today,
> Also the future implementation might need more kernel data. This is
> important for interfaces such as NAPI, where interrupts handling changes
> on the fly.

This depends on the information :)  Some information that is useful for 
balancing is only [easily] available from userspace.   In-kernel 
information may be easily exported through "sysfs", which is designed to 
export in-kernel information.

Further, for NAPI and networking in general, it is recommended to bind 
each NIC to a single interrupt, and never change that binding. 
Delivering a single NIC's interrupts to multiple CPUs leads to a 
noticeable performance loss.  This is why some people complain that 
their specific network setups are faster on a uniprocessor kernel than 
an SMP kernel.

I have not examined interrupt delivery for other peripherals, such at 
ATA or SCSI hosts, but for networking you definitely want to statically 
bind each NIC's irqs to a separate CPU, and then not touch that binding.

Best regards, and thanks again for your valuable feedback,

	Jeff



