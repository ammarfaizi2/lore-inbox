Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWIRT0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWIRT0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWIRT0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:26:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:911 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751106AbWIRT0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:26:52 -0400
Subject: Re: tracepoint maintainance models
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vara Prasad <prasadav@us.ibm.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       systemtap <systemtap@sourceware.org>
In-Reply-To: <450EEF2E.3090302@us.ibm.com>
References: <20060917143623.GB15534@elte.hu>
	 <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>
	 <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>
	 <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>
	 <1158594491.6069.125.camel@localhost.localdomain>
	 <20060918152230.GA12631@elte.hu>
	 <1158596341.6069.130.camel@localhost.localdomain>
	 <20060918161526.GL3951@redhat.com>
	 <1158598927.6069.141.camel@localhost.localdomain>
	 <450EEF2E.3090302@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 20:49:40 +0100
Message-Id: <1158608981.6069.167.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 12:10 -0700, ysgrifennodd Vara Prasad:
> I am not sure i quiet understand your line number part of the proposal. 
> Does this proposal assume we have access to source code while generating 
> dynamic probes?

Its one route - or we dump it into an ELF section in the binary.

> This still doesn't solve the problem of compiler optimizing such that a 
> variable i would like to read in my probe not being available at the 
> probe point.

Then what we really need by the sound of it is enough gcc smarts to do
something of the form

	.section "debugbits"
	
	.asciiz 'hook_sched'
	.dword l1	# Address to probe
	.word 1		# Argument count
	.dword gcc_magic_whatregister("next"); [ reg num or memory ]
	.dword gcc_magic_whataddress("next"); [ address if exists]


Can gcc do any of that for us today ?

