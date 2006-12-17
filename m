Return-Path: <linux-kernel-owner+w=401wt.eu-S1752501AbWLQMGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWLQMGh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbWLQMGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:06:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58372 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbWLQMGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:06:36 -0500
Date: Sun, 17 Dec 2006 04:06:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrei.popa@i-neo.ro
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061217040620.91dac272.akpm@osdl.org>
In-Reply-To: <1166314399.7018.6.camel@localhost>
References: <1166314399.7018.6.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 02:13:18 +0200
Andrei Popa <andrei.popa@i-neo.ro> wrote:

> Hello,
> I had filesystem data corruption with rtorrent with 2.6.19.
> I tried recent git with Peter Zijlstra patch
> http://lkml.org/lkml/2006/12/16/144 and it seems that the problem is
> fixed.
> 

oh crap, I'd forgotten that test_clear_page_dirty() now fiddles with the
ptes.

I'd be really surprised if this was all due to a race though.  Is everyone
who has observed this problem running SMP and/or premptible kernels?

Peter, why isn't that proposed patch's cleaning of the pte racy against
do_wp_page()?
