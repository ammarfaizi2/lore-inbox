Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWISXqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWISXqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 19:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWISXqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 19:46:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54167 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750811AbWISXqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 19:46:45 -0400
Subject: Re: [PATCH] Linux Kernel Markers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
In-Reply-To: <20060919175405.GC26339@Krystal>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>
	 <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com>
	 <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org>
	 <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com>
	 <45102641.7000101@google.com>  <20060919175405.GC26339@Krystal>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 01:08:45 +0100
Message-Id: <1158710925.32598.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-19 am 13:54 -0400, ysgrifennodd Mathieu Desnoyers:
> Very good idea.. However, overwriting the second instruction with a jump could
> be dangerous on preemptible and SMP kernels, because we never know if a thread
> has an IP in any of its contexts that would return exactly at the middle of the
> jump. 

No: on x86 it is the *same* case for all of these even writing an int3.
One byte or a megabyte,

You MUST ensure that every CPU executes a serializing instruction before
it hits code that was modified by another processor. Otherwise you get
CPU errata and the CPU produces results which vendors like to describe
as "undefined".

Thus you have to serialize, and if you are serializing it really doesn't
matter if you write a byte, a paragraph or a page.

Alan

