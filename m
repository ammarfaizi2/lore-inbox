Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWJEWkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWJEWkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWJEWka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:40:30 -0400
Received: from mga05.intel.com ([192.55.52.89]:4000 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932400AbWJEWk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:40:28 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,267,1157353200"; 
   d="scan'208"; a="142295439:sNHT530088398"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Andrew Morton <akpm@osdl.org>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061005143748.2f6594a2.akpm@osdl.org>
References: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411>
	 <20061005143748.2f6594a2.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel
Date: Thu, 05 Oct 2006 14:51:25 -0700
Message-Id: <1160085085.8035.222.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 14:37 -0700, Andrew Morton wrote:

> 
> Tim and Ananiev report that the recent WARN_ON_ONCE changes cause increased
> cache misses with the tbench workload.  Apparently due to the access to the
> newly-added static variable.
> 
> Rearrange the code so that we don't touch that variable unless the warning is
> going to trigger.
> 
> Also rework the logic so that the static variable starts out at zero, so we
> can move it into bss.
> 
> It would seem logical to mark the static variable as __read_mostly too.  But
> it would be wrong, because that would put it back into the vmlinux image, and
> the kernel will never read from this variable in normal operation anyway. 
> Unless the compiler or hardware go and do some prefetching on us?
> 
> For some reason this patch shrinks softirq.o text by 40 bytes.
> 

Andrew,

Thanks for the patch.  I tested it and it helped fix tbench regression
seen earlier and reduced the cache misses. 

Tim
