Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWITKIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWITKIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 06:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWITKIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 06:08:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59349 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750933AbWITKIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 06:08:31 -0400
Subject: Re: [PATCH] Linux Kernel Markers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: prasanna@in.ibm.com, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
In-Reply-To: <45110C6B.6010909@aitel.hist.no>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>
	 <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com>
	 <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org>
	 <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com>
	 <45110C6B.6010909@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 11:30:26 +0100
Message-Id: <1158748226.7705.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 11:39 +0200, ysgrifennodd Helge Hafting:
> Yes, 5 bytes is not an atomic write except on 64-bit. So a race is possible.

Untrue as well. Pentium and later have CMPXCHG8.

> How about this workaround:
> 1. Overwrite the start of the function with a hlt, which is atomic.
> 2. Write that 5-byte jump after the hlt.
> 3. Overwrite the hlt with nop so things will work
> 4. interrupt any cpus that got stuck on the hlt - or just wait for the 
> timer.

CPU errata time again. You have to synchronize.

Alan

