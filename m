Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVJSTuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVJSTuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVJSTuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:50:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751260AbVJSTuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:50:14 -0400
Date: Wed, 19 Oct 2005 12:49:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, gfiala@s.netic.de
Subject: Re: large files unnecessary trashing filesystem cache?
Message-Id: <20051019124927.643a0603.akpm@osdl.org>
In-Reply-To: <200510191754.17963.ioe-lkml@rameria.de>
References: <200510182201.11241.gfiala@s.netic.de>
	<20051018213721.236b2107.akpm@osdl.org>
	<1129720232.435629a8753d3@webmail.LF.net>
	<200510191754.17963.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> wrote:
>
> Hi,
> 
> On Wednesday 19 October 2005 13:10, gfiala@s.netic.de wrote:
> > Zitat von Andrew Morton <akpm@osdl.org>:

Please don't edit Cc lines.  Just do reply-to-all.

> > > So I'd also suggest a new resource limit which, if set, is copied into the
> > > applications's file_structs on open().  So you then write a little wrapper
> > > app which does setrlimit()+exec():
> > > 
> > > 	limit-cache-usage -s 1000 my-fave-backup-program <args>
> > > 
> > > Which will cause every file which my-fave-backup-program reads or writes to
> > > be limited to a maximum pagecache residency of 1000 kbytes.
> > 
> > Or make it another 'ulimit' parameter...

That's what I said.  ulimit is the shell interface to resource limits.

> Which is already there: There is an ulimit for "maximum RSS", 
> which is at least a superset of "maximum pagecache residency".

RSS is a quite separate concept from pagecache.

> This is already settable and known by many admins. But AFAIR it is not
> honoured by the kernel completely, right?
> 
> But per file is a much better choice, since this would allow
> concurrent streaming. This is needed to implement timeshifting at least[1].
> 
> So either I miss something or this is no proper solution yet.

I described a couple of ways in which this can be done from userspace with
LD_PRELOAD.
