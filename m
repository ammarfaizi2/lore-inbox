Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUDRFxK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264140AbUDRFxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:53:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:58787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264137AbUDRFxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:53:06 -0400
Date: Sat, 17 Apr 2004 22:52:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Singer <elf@buici.com>
Cc: wli@holomorphy.com, elf@buici.com, linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-Id: <20040417225243.0faa6fc4.akpm@osdl.org>
In-Reply-To: <20040418053857.GC19595@flea>
References: <20040417193855.GP743@holomorphy.com>
	<20040417212958.GA8722@flea>
	<20040417162125.3296430a.akpm@osdl.org>
	<20040417233037.GA15576@flea>
	<20040417165151.24b1fed5.akpm@osdl.org>
	<20040418015918.GU743@holomorphy.com>
	<20040417205338.71bed81b.akpm@osdl.org>
	<20040418053857.GC19595@flea>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer <elf@buici.com> wrote:
>
> On Sat, Apr 17, 2004 at 08:53:38PM -0700, Andrew Morton wrote:
> > William Lee Irwin III <wli@holomorphy.com> wrote:
> > >
> > >  On Sat, Apr 17, 2004 at 04:51:51PM -0700, Andrew Morton wrote:
> > >  > I'd assume that setting swappiness to zero simply means that you still have
> > >  > all of your libc in pagecache when running ls.
> > >  > What happens if you do the big file copy, then run `sync', then do the ls?
> > >  > Have you experimented with the NFS mount options?  v2? UDP?
> > > 
> > >  I wonder if the ptep_test_and_clear_young() TLB flushing is related.
> > 
> > That, or page_referenced() always returns true on this ARM implementation
> > or some such silliness.  Everything here points at the VM being unable to
> > reclaim that clean pagecache.
> 
> How can I tell?

Well some more descriptions of what the system does after that copy-to-nfs
would help.  Does it _ever_ come good, or is a reboot needed, etc?

What does `vmstat 1' say during the copy, and during the ls?

/proc/vmstats before and after the ls.

Try doing the copy, then when it has finished do the old
memset(malloc(24M)) and monitor the `vmstat 1' output while it runs,
capture /proc/meminfo before and after.

None of the problems you report are present on x86 as far as I can tell,
so...

