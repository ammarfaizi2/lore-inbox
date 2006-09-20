Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWITBI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWITBI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 21:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWITBI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 21:08:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:13739 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750814AbWITBI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 21:08:57 -0400
Date: Wed, 20 Sep 2006 06:38:52 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060920010852.GA7469@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919175405.GC26339@Krystal> <1158710925.32598.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158710925.32598.120.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Wed, Sep 20, 2006 at 01:08:45AM +0100, Alan Cox wrote:
> Ar Maw, 2006-09-19 am 13:54 -0400, ysgrifennodd Mathieu Desnoyers:
> > Very good idea.. However, overwriting the second instruction with a jump could
> > be dangerous on preemptible and SMP kernels, because we never know if a thread
> > has an IP in any of its contexts that would return exactly at the middle of the
> > jump. 
> 
> No: on x86 it is the *same* case for all of these even writing an int3.
> One byte or a megabyte,
> 
> You MUST ensure that every CPU executes a serializing instruction before
> it hits code that was modified by another processor. Otherwise you get
> CPU errata and the CPU produces results which vendors like to describe
> as "undefined".

Are you referring to Intel erratum "unsynchronized cross-modifying code"
- where it refers to the practice of modifying code on one processor
where another has prefetched the unmodified version of the code. 

Thanks
Prasanna

> 
> Thus you have to serialize, and if you are serializing it really doesn't
> matter if you write a byte, a paragraph or a page.
> 

-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
