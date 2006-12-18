Return-Path: <linux-kernel-owner+w=401wt.eu-S1754644AbWLRVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbWLRVqU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbWLRVqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:46:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48642 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbWLRVqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:46:19 -0500
Date: Mon, 18 Dec 2006 13:43:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061218134342.1ae02f75.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<1166466272.10372.96.camel@twins>
	<Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	<1166468651.6983.6.camel@localhost>
	<Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	<1166471069.6940.4.camel@localhost>
	<Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 12:14:35 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> OR:
> 
>  - page_mkclean_one() is simply buggy.
> 
> And I'm starting to wonder about the second case. But it all LOOKS really 
> fine - I can't see anything wrong there (it uses the extremely 
> conservative "ptep_get_and_clear()", and seems to flush everything right 
> too, through "ptep_establish()").

What does the call to page_check_address() in there do?

It'd be good to have a printk in there to see if it's triggering.

Is this all correct for non-linear VMAs?  (rtorrent doesn't use
MAP_NONLINEAR though).
