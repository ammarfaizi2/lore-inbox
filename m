Return-Path: <linux-kernel-owner+w=401wt.eu-S1754796AbWLSA3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbWLSA3R (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbWLSA3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:29:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35180 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754796AbWLSA3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:29:16 -0500
Date: Mon, 18 Dec 2006 16:29:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166487191.6869.1.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612181626110.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
  <1166471069.6940.4.camel@localhost>  <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
  <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>  <1166476297.6862.1.camel@localhost>
  <5a4c581d0612181400t347fc9efx69e55efb3ef40c45@mail.gmail.com> 
 <Pine.LNX.4.64.0612181434210.3479@woody.osdl.org> <1166487191.6869.1.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Andrei Popa wrote:
> 
> the corrupted file has a chink full with zeros
> 
> http://193.226.119.62/corruption0.jpg
> http://193.226.119.62/corruption1.jpg

Thanks. Yup, filled with zeroes, and the corruption stops (but does _not_ 
start) at a page boundary.

That _does_ look very much like it was filled in linearly, then written 
out to disk when it was in the middle of the page, and then we simply lost 
the further writes that should also have gone on to that page. All 
consistent with dropping a dirty bit somewhere in the middle of the page 
updates.

Which we kind of knew must be the issue anyway, but it's good to know that 
the corruption pattern is consistent with what we're trying to figure out.

		Linus
