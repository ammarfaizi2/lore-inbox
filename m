Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVGLPSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVGLPSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVGLPSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:18:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50160 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261572AbVGLPRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:17:00 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.57046.817407.562018@tut.ibm.com>
Date: Tue, 12 Jul 2005 10:16:38 -0500
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
	<Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-2?Q?Tomasz_K=B3oczko?= writes:
 > On Mon, 11 Jul 2005, Tom Zanussi wrote:
 > 
 > >
 > > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
 > > logging and buffering capability, which does not currently exist in
 > > the kernel.
 > >
 > > relayfs key features:
 > >
 > > - Extremely efficient high-speed logging/buffering
 > 
 > Usualy/for now relayfs is used as base infrastructure for variuos
 > debuging/measuring.
 > IMO storing raw data and transfer them to user space it is wrong way.
 > Why ? Becase i adds very big overhead for memory nad storage.
 > Big .. compare to in situ storing partialy analyzed data in conters
 > and other like it is in DTrace.
 > 

But isn't it supposed to be a good thing to keep analysis out of the
kernel if possible?  And many things can't be aggregated, such as the
detailed sequence of events in a trace.  Anyway, it doesn't have to be
an 'all or nothing' thing.  For some applications it may make sense to
do some amount of filtering and aggregation in the kernel.  AFAICS
DTrace takes this to the extreme and does everything in the kernel,
and IIRC it can't easily be made to general system tracing along the
lines of LTT, for instance.

 > IMO much better will be add base/template set of functions for use in 
 > KProbes probes which will come with KProbes code as base tool set. It will 
 > allow cut transfered data size from megabites/gigabyutes to hundret 
 > bytes/kilo bytes, make debuging/measuring more smooth without additional 
 > latency for transfer data outside kernel space.

The systemtap project is using kprobes along these lines.

Tom



