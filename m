Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVFUO3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVFUO3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVFUO0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:26:03 -0400
Received: from dvhart.com ([64.146.134.43]:30385 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262069AbVFUOWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:22:15 -0400
Date: Tue, 21 Jun 2005 07:22:14 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <235990000.1119363734@[10.10.2.4]>
In-Reply-To: <20050620232925.41bded87.akpm@osdl.org>
References: <208690000.1119330454@[10.10.2.4]> <20050620232925.41bded87.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, after fixing the build failure with Andy's patch here:
>> 
>> http://mbligh.org/abat/apw_pci_assign_unassigned_resources
> 
> yup, I have that now.

Sweet, thanks.
 
>> I get a boot failure on the NUMA-Q box. Full log is here:
>> 
>> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/6184/debug/console.log
>> 
>> But at the end it prints out lots of wierd scheduler stuff, then one more
>> message, then dies:
>> 
>> | migration cost matrix (max_cache_size: 2097152, cpu: 700 MHz):
>> ---------------------
> 
> That's Ingo debug stuff.
> 
>> --------------------------------
>> NET: Registered protocol family 16
> 
> Well it got up to core_initcall(netlink_proto_init);
> 
>> I guess I'll try backing out the scheduler patches unless someone else 
>> has a brighter idea?
> 
> It doesn't look like a scheduler thing.  Tried enabling initcall_debug?

Humpf. I agree it seemed to get a bit further than that, but I kicked off
a new test before I went to bed, and it does seem to work w/o the sched
patches:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

see the "moe" column, comparing:

2.6.12-mm1
+apw_pci_assign_unass
+nosched_2.6.12-mm1

vs

2.6.12-mm1
+apw_pci_assign_unass

rows ?

I can still do initcall debug if you want. Or I guess it's binary chop
search amongst sched patches (or at least the ones that are new in 
this -mm ?)

M.
