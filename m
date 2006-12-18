Return-Path: <linux-kernel-owner+w=401wt.eu-S1754572AbWLRUpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbWLRUpi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbWLRUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:45:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44647 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbWLRUpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:45:38 -0500
Date: Mon, 18 Dec 2006 12:41:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
 <1166471069.6940.4.camel@localhost> <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Linus Torvalds wrote:
> 
> But at the same time, it's interesting that it still happens when we try 
> to re-add the dirty bit. That would tell me that it's one of two cases:

Forget that. There's a third case, which is much more likely:

 - Andrew's patch had a ", 1" where it _should_ have had a ", 0".

This should be fairly easy to test: just change every single ", 1" case in 
the patch to ", 0".

The only case that _definitely_ would want ",1" is actually the case that 
already calls page_mkclean() directly: clear_page_dirty_for_io(). So no 
other ", 1" is valid, and that one that needed it already avoided even 
calling the "test_clear_page_dirty()" function, because it did it all by 
hand.

What happens for you in that case?

		Linus
