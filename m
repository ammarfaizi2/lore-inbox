Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUJXLWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUJXLWE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUJXLVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:21:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:30900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261461AbUJXLUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:20:32 -0400
Date: Sun, 24 Oct 2004 04:18:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] Fix incorrect kunmap_atomic in pktcdvd
Message-Id: <20041024041827.664845da.akpm@osdl.org>
In-Reply-To: <m3oeisz7uh.fsf@telia.com>
References: <m3wtxhibo9.fsf@telia.com>
	<20041024032546.52314e23.akpm@osdl.org>
	<m3oeisz7uh.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Peter Osterlund <petero2@telia.com> wrote:
> > >
> > >  The pktcdvd driver uses kunmap_atomic() incorrectly. The function is
> > >  supposed to take an address as the first parameter, but the pktcdvd
> > >  driver passed a page pointer. Thanks to Douglas Gilbert and Jens Axboe
> > >  for discovering this.
> > 
> > You're about the 7,000th person to make that mistake.  We really should
> > catch it via typechecking but the code's really lame and nobody ever got
> > around to rotorooting it.
> 
> Why was the interface made different from kmap()/kunmap() in the first
> place? Wouldn't it have made more sense to let kunmap_atomic() take a
> page pointer as the first parameter?

No, kmap-atomic() maps a single page into the CPU's address space by making
a pte point at the page.  To unmap that page we need to get at the pte, not
at the page.  If kmap_atomic() were to take a pageframe address we'd need
to search the whole fixmap space for the corresponding page - a reverse
lookup.


