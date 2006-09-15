Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWIOSGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWIOSGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIOSGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:06:23 -0400
Received: from opersys.com ([64.40.108.71]:49929 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751312AbWIOSGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:06:22 -0400
Message-ID: <450AEDF2.3070504@opersys.com>
Date: Fri, 15 Sep 2006 14:16:18 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal>	<20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu>	<4509B03A.3070504@am.sony.com>	<1158320406.29932.16.camel@localhost.localdomain>	<Pine.LNX.4.64.0609151339190.6761@scrub.home>	<1158323938.29932.23.camel@localhost.localdomain> <20060915104527.89396eaf.akpm@osdl.org>
In-Reply-To: <20060915104527.89396eaf.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> This is something I'm curious about.  AFAICT there are two(*) reasons for
> wanting static tracepoints:
> 
> a) to be able to get at local variables and
> 
> b) as a "marker" somewhere within the body of a function - the
>    expectation here is that identifiying that particular spot in the
>    function would be hard without some marker which moves around as the
>    functions itself is modified over time.
> 
> 
> If a) is true, then isn't this simply a feature request against the
> systemtap infrastructure?  There's no reason per-se why a kprobe point
> cannot access locals, using the dwarf debug info.  It'll be somewhat
> unreliable, because stack slots and registers go out of scope and get
> reused for other things.  But as any gdb user will know, it's still
> useful.

I believe this has been addressed by Frank in his other email, so I'll
skip.

> As for b), if it was _really_ an advantage to be able to identify
> particular places within the body of a function then one could concoct a
> macro which inserts some info into a separate elf section and which adds no
> code at all to actual .text.

Yes, and this specific suggestion has been made a number of times.
Though, then, this is an implementation debate and there are number
of things which could be made available as build-time options. The
emerging consensus in this thread, however, that there is a clear
need for a way for statically marking up important events, and this
point has been emphasized both by those who have maintained
infrastructure based on "static" tracepoints and those maintaining
such infrastructure based on "dynamic" tracepoints.

> Although IMO this is a bit lame - it is quite possible to go into
> SexySystemTapGUI, click on a particular kernel file-n-line and have
> systemtap userspace keep track of that place in the kernel source across
> many kernel versions: all it needs to do is to remember the file+line and a
> snippet of the surrounding text, for readjustment purposes.

Sure, if you're a kernel developer, but as I've explained numberous
times in this thread, there are far more many users of tracing than
kernel developers.

> (*) I don't buy the performance arguments: kprobes are quick, and I'd
> expect that the CPU consumption of the destination of the probe is
> comparable to or higher than the cost of taking the initial trap.

Please see Mathieu's earlier posting of numbers comparing kprobes to
static points. Nevertheless, I do not believe that the use of kprobes
should be pitted against static instrumentation, the two are
orthogonal.

Karim

