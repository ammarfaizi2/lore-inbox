Return-Path: <linux-kernel-owner+w=401wt.eu-S932336AbXAQOpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbXAQOpk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbXAQOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:45:39 -0500
Received: from pat.uio.no ([129.240.10.15]:49491 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932336AbXAQOpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:45:39 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <1169044186.22935.122.camel@twins>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org>  <1168985323.5975.53.camel@lappy>
	 <1168986466.6056.52.camel@lade.trondhjem.org>
	 <1169001692.22935.84.camel@twins>
	 <1169014515.6065.5.camel@lade.trondhjem.org>
	 <1169023798.22935.96.camel@twins>
	 <1169041814.6102.3.camel@lade.trondhjem.org>
	 <1169044186.22935.122.camel@twins>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 09:45:15 -0500
Message-Id: <1169045115.6102.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.2, required=12.0, autolearn=disabled, AWL=-1.250)
X-UiO-Scanned: FD106A09A343D9859E33F354688B73314F92EC6C
X-UiO-SPAM-Test: remote_host: 129.240.10.9 spam_score: -11 maxlevel 200 minaction 2 bait 0 mail/h: 434 total 7540 max/h 7540 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 15:29 +0100, Peter Zijlstra wrote:
> I was thinking that since the server needs to actually sync the page a
> commit might be quite expensive (timewise), hence I didn't want to flush
> too much, and interleave them with writing out some real pages to
> utilise bandwidth.

Most servers just call fsync()/fdatasync() whenever we send a COMMIT, in
which case the extra round trips are just adding unnecessary latency.



