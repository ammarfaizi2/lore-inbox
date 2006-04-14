Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWDNVeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWDNVeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWDNVeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:34:36 -0400
Received: from ns.suse.de ([195.135.220.2]:25829 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030188AbWDNVeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:34:36 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [i386, x86-64] ioapic_register_intr() and assign_irq_vector() questions
Date: Fri, 14 Apr 2006 23:34:18 +0200
User-Agent: KMail/1.9.1
Cc: "Jan Beulich" <jbeulich@novell.com>, tom.l.nguyen@intel.com,
       linux-kernel@vger.kernel.org
References: <443FE6E00200007800015D6E@emea1-mh.id2.novell.com>
In-Reply-To: <443FE6E00200007800015D6E@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604142334.18923.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 19:16, Jan Beulich wrote:
> >> Looking at the call paths assign_irq_vector() can get called from, I
> >> would think this function, namely as it's using static variables,
> >> lacks synchronization - is there any (hidden) reason this is not
> >> needed here?
> 
> >It is only called during system initialization which is single threaded. 
> >If someone added ioapic hotplug they would need to do something about 
> >this.
> 
> Hmm, as I looked through this I expected this to be possibly called also later, as it seems to be on paths reachable
> from exported functions (which clearly can be called only after the single-threaded phase is over.

If it's not called from in tree modules we don't care. But should probably
bunk the exports if they are not needed. Which ones were it?

-Andi
