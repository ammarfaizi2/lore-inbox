Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUDRFi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbUDRFi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:38:59 -0400
Received: from florence.buici.com ([206.124.142.26]:46208 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264132AbUDRFi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:38:58 -0400
Date: Sat, 17 Apr 2004 22:38:57 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, elf@buici.com,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418053857.GC19595@flea>
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418015918.GU743@holomorphy.com> <20040417205338.71bed81b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417205338.71bed81b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 08:53:38PM -0700, Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> >  On Sat, Apr 17, 2004 at 04:51:51PM -0700, Andrew Morton wrote:
> >  > I'd assume that setting swappiness to zero simply means that you still have
> >  > all of your libc in pagecache when running ls.
> >  > What happens if you do the big file copy, then run `sync', then do the ls?
> >  > Have you experimented with the NFS mount options?  v2? UDP?
> > 
> >  I wonder if the ptep_test_and_clear_young() TLB flushing is related.
> 
> That, or page_referenced() always returns true on this ARM implementation
> or some such silliness.  Everything here points at the VM being unable to
> reclaim that clean pagecache.

How can I tell?  Is it something like this: because page_referenced()
always returns true (which I haven't investigated) then the page
eviction code cannot distinguish mapped from cache pages and therefore
selects valuable, mapped pages.
