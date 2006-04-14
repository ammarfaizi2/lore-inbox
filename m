Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWDNRQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWDNRQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDNRQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:16:10 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:33029
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751298AbWDNRQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:16:09 -0400
Message-Id: <443FE6E00200007800015D6E@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 14 Apr 2006 19:16:00 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <tom.l.nguyen@intel.com>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [i386, x86-64] ioapic_register_intr() and
	assign_irq_vector() questions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Looking at the call paths assign_irq_vector() can get called from, I
>> would think this function, namely as it's using static variables,
>> lacks synchronization - is there any (hidden) reason this is not
>> needed here?

>It is only called during system initialization which is single threaded. 
>If someone added ioapic hotplug they would need to do something about 
>this.

Hmm, as I looked through this I expected this to be possibly called also later, as it seems to be on paths reachable
from exported functions (which clearly can be called only after the single-threaded phase is over.

Jan
