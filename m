Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVGLQ33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVGLQ33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGLQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:27:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53161 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261548AbVGLQ1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:27:20 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.61271.924455.965538@tut.ibm.com>
Date: Tue, 12 Jul 2005 11:27:03 -0500
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
	<Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl>
	<17107.57046.817407.562018@tut.ibm.com>
	<Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-2?Q?Tomasz_K=B3oczko?= writes:
 > On Tue, 12 Jul 2005, Tom Zanussi wrote:
 > 
 > > =?ISO-8859-2?Q?Tomasz_K=B3oczko?= writes:
 > > > On Mon, 11 Jul 2005, Tom Zanussi wrote:
 > > >
 > > > >
 > > > > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
 > > > > logging and buffering capability, which does not currently exist in
 > > > > the kernel.
 > > > >
 > > > > relayfs key features:
 > > > >
 > > > > - Extremely efficient high-speed logging/buffering
 > > >
 > > > Usualy/for now relayfs is used as base infrastructure for variuos
 > > > debuging/measuring.
 > > > IMO storing raw data and transfer them to user space it is wrong way.
 > > > Why ? Becase i adds very big overhead for memory nad storage.
 > > > Big .. compare to in situ storing partialy analyzed data in conters
 > > > and other like it is in DTrace.
 > > >
 > >
 > > But isn't it supposed to be a good thing to keep analysis out of the
 > > kernel if possible?
 > 
 > As long as you try for example measure (?) .. not.
 > 
 > > And many things can't be aggregated, such as the detailed sequence of 
 > > events in a trace.
 > 
 > DTrace real examples shows something completly diffret.
 > MANY things (if not ~almost all) can be kept only in aggregated form 
 > during experiments.

But you can also do the aggregation in user space if you have a cheap
way of getting it there, as we've shown with some of the examples.
Why do you need it in the kernel?  And what do you do when you need to
know the exact sequence of events, especially if you don't really know
what you're looking for?

 > 
 > > Anyway, it doesn't have to be
 > > an 'all or nothing' thing.  For some applications it may make sense to
 > > do some amount of filtering and aggregation in the kernel.  AFAICS
 > > DTrace takes this to the extreme and does everything in the kernel,
 > > and IIRC it can't easily be made to general system tracing along the
 > > lines of LTT, for instance.
 > 
 > Try measure number of dysk I/O operation without touching storage for 
 > store raw data. What you need ? only one counter (few bytes) instead of huge 
 > amount of memeory for buffer and store logs. Try measure something like
 > scheduler with possible small system distruption.

Most of the time the data is just being buffered and only when the
buffer is full is it written to disk, as one write.  If that's too
disruptive, then maybe you do need to do some aggregation in the kernel,
but it sounds like a special case.

As for measuring the sheduler, I know that people have used it for
that e.g. Steven Rostedt's logdev device, which he uses to trace
problems in the RT kernel.

Tom


