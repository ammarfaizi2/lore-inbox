Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVHHWha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVHHWha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVHHWha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:37:30 -0400
Received: from fmr23.intel.com ([143.183.121.15]:46268 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932312AbVHHWh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:37:27 -0400
Message-Id: <200508082236.j78MaXg20909@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <ak@suse.de>, <christoph@lameter.com>,
       <dwg@au1.ibm.com>
Subject: RE: [RFC] Demand faulting for large pages
Date: Mon, 8 Aug 2005 15:36:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <1123539400.3122.365.camel@localhost.localdomain>
Thread-Index: AcWcZ50qxctxXkp0SkmwwCcBd1IvMQAANToQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Monday, August 08, 2005 3:17 PM
> The reason for the VM_FAULT_SIGBUS default return is because I thought a
> fault on a pte_present hugetlb page was an invalid/unhandled fault. 
> I'll have another think about races to the fault handler though.

Two threads fault on the same pte, one won the race, install a pte, 2nd
thread then walk the page table, found the pte inserted by the first
thread, exit with SIGBUS, kernel then kills the entire app with sigbus.


> I've definitely been able to produce some strange behavior on 2.6.7
> relative to your post about this topic here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0406.2/0234.html 
> I confirmed the fix in 2.6.8 and also don't see the problem when using
> my demand fault patch.  Do you have a copy of the program you used to
> generate the Oops in the post linked above so I can use it as a test
> case?  I'd guess either the problem is gone entirely with demand
> faulting, or just harder to trigger.

Demanding paging doesn't solve this problem.  It is related to how pmds
are freed.


- Ken

