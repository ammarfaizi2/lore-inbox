Return-Path: <linux-kernel-owner+w=401wt.eu-S1754708AbWLRWee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbWLRWee (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbWLRWee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:34:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52335 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbWLRWec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:34:32 -0500
Date: Mon, 18 Dec 2006 14:32:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166476297.6862.1.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612181426390.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
  <1166471069.6940.4.camel@localhost>  <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
  <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org> <1166476297.6862.1.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Andrei Popa wrote:
> >
> > This should be fairly easy to test: just change every single ", 1" case in 
> > the patch to ", 0".
> >
> > What happens for you in that case?
> 
> I have file corruption.

Magic. And btw, _thanks_ for being such a great tester.

So now I have one more thng for you to try, it you can bother:

There's exactly two call sites that call "page_mkclean()" (an dthat is the 
only thing in turn that calls "page_mkclean_one()", which we already 
determined will cause the corruption). 

Both of them do 

	if (mapping_cap_account_dirty(mapping)) {
			..

things, although they do slightly different things inside that if in your 
patched kernel.

Can you just TOTALLY DISABLE that case for the test_clear_page_dirty() 
case? Just do an "#if 0 .. #endif" around that whole if-statement, leaving 
the _only_ thing that actually calls "page_mkclean()" to be the 
"clear_page_dirty_for_io()" call.

Do you still see corruption?

		Linus
