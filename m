Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWIORqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWIORqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWIORqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:46:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751261AbWIORqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:46:44 -0400
Date: Fri, 15 Sep 2006 10:45:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-Id: <20060915104527.89396eaf.akpm@osdl.org>
In-Reply-To: <1158323938.29932.23.camel@localhost.localdomain>
References: <20060914033826.GA2194@Krystal>
	<20060914112718.GA7065@elte.hu>
	<Pine.LNX.4.64.0609141537120.6762@scrub.home>
	<20060914135548.GA24393@elte.hu>
	<Pine.LNX.4.64.0609141623570.6761@scrub.home>
	<20060914171320.GB1105@elte.hu>
	<Pine.LNX.4.64.0609141935080.6761@scrub.home>
	<20060914181557.GA22469@elte.hu>
	<4509B03A.3070504@am.sony.com>
	<1158320406.29932.16.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609151339190.6761@scrub.home>
	<1158323938.29932.23.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 13:38:58 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> gcc -g produces extensive annotations which are then usably by many
> tools other than gdb.

This is something I'm curious about.  AFAICT there are two(*) reasons for
wanting static tracepoints:

a) to be able to get at local variables and

b) as a "marker" somewhere within the body of a function - the
   expectation here is that identifiying that particular spot in the
   function would be hard without some marker which moves around as the
   functions itself is modified over time.


If a) is true, then isn't this simply a feature request against the
systemtap infrastructure?  There's no reason per-se why a kprobe point
cannot access locals, using the dwarf debug info.  It'll be somewhat
unreliable, because stack slots and registers go out of scope and get
reused for other things.  But as any gdb user will know, it's still
useful.



As for b), if it was _really_ an advantage to be able to identify
particular places within the body of a function then one could concoct a
macro which inserts some info into a separate elf section and which adds no
code at all to actual .text.

Although IMO this is a bit lame - it is quite possible to go into
SexySystemTapGUI, click on a particular kernel file-n-line and have
systemtap userspace keep track of that place in the kernel source across
many kernel versions: all it needs to do is to remember the file+line and a
snippet of the surrounding text, for readjustment purposes.


(*) I don't buy the performance arguments: kprobes are quick, and I'd
expect that the CPU consumption of the destination of the probe is
comparable to or higher than the cost of taking the initial trap.
