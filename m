Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVGLRYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVGLRYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVGLRYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:24:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34705 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261709AbVGLRXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:23:13 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.64629.717907.706682@tut.ibm.com>
Date: Tue, 12 Jul 2005 12:23:01 -0500
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com, prasadav@us.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
	<Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl>
	<17107.57046.817407.562018@tut.ibm.com>
	<Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl>
	<17107.61271.924455.965538@tut.ibm.com>
	<Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-2?Q?Tomasz_K=B3oczko?= writes:
 > On Tue, 12 Jul 2005, Tom Zanussi wrote:
[...]
 > >
 > > Most of the time the data is just being buffered and only when the
 > > buffer is full is it written to disk, as one write.  If that's too
 > > disruptive, then maybe you do need to do some aggregation in the kernel,
 > > but it sounds like a special case.
 > 
 > OK .. "so you can say better is stop flushing buffers on measure which 
 > wil take day or more" ? :_)
 > Some DTrace probes/technik are specialy prepared for long or evel very 
 > long time experiment wich will only prodyce few lines results on end of 
 > experiment.
 > Look at DTrace documentation for speculative tracing:
 > http://docs.sun.com/app/docs/doc/817-6223/6mlkidli7?a=view
 > 

It's also possible to do long-running 'experiments' using relayfs, and
never write anything at all to disk.  Here's an example prototype I
did using a Perl interpreter embedded in the user space event-reading
loop:

http://www.listserv.shafik.org/pipermail/ltt-dev/2004-August/000649.html

 > Some experiments do not have deterinistic time and must be finished after 
 > i. e. "occasional failing". What if it will take so long so you will fill 
 > all avalaible storage in relayfs way ?
 > OK, never mind .. you have discontinued storage. Using kind speculative 
 > tracing way I'll have result *just after* "occasional failing" and you 
 > will start parse data stored using relayfs.

As in the example above, you don't necessary need to fill any
available storage.  You can also use relayfs in 'circular-buffer'
mode, which would capture a buffer full of events up the point of your
failure.  Sounds like speculative tracing to me.

Tom


