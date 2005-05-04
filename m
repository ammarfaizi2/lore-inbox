Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVEDLKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVEDLKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 07:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVEDLKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 07:10:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:48608 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261622AbVEDLKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 07:10:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17016.44418.735245.751747@alkaid.it.uu.se>
Date: Wed, 4 May 2005 13:09:54 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3: Bad page state at prep_new_page
In-Reply-To: <20050429045447.44649c8e.akpm@osdl.org>
References: <17006.3525.908807.563680@alkaid.it.uu.se>
	<20050429045447.44649c8e.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Mikael Pettersson <mikpe@user.it.uu.se> wrote:
 > >
 > > My trusty network server (440BX PentiumIII box serving NFS and News)
 > >  just threw the following at me:
 > > 
 > >  Bad page state at prep_new_page (in process 'python', page c10984e0)
 > >  flags:0x20021008 mapping:00000000 mapcount:0 count:0
 > >  Backtrace:
 > >   [<c0137555>] bad_page+0x75/0xb0
 > >   [<c01378aa>] prep_new_page+0x2a/0x70
 > >   [<c0137e60>] buffered_rmqueue+0xc0/0x1c0
 > >   [<c01380f0>] __alloc_pages+0xc0/0x400
 > >   [<c01425a9>] do_anonymous_page+0x79/0x150
 > >   [<c0142870>] do_no_page+0x1f0/0x360
 > >   [<c0142c2d>] handle_mm_fault+0x13d/0x170
 > >   [<c0110c92>] do_page_fault+0x2a2/0x6bf
 > >   [<c0111d12>] recalc_task_prio+0xc2/0x170
 > >   [<c026b49b>] schedule+0x31b/0x5c0
 > >   [<c01109f0>] do_page_fault+0x0/0x6bf
 > >   [<c0102dbf>] error_code+0x4f/0x54
 > >  Trying to fix it up, but a reboot is needed
 > > 
 > >  It's running 2.6.12-rc3 since last Friday, but had been running
 > >  2.6.12-rc2 for weeks before that w/o problems. 2.4 kernels and
 > >  most recent 2.6 kernels have always been rock solid on it.
 > > 
 > 
 > PG_swapcache is set.  It wasn't set when this page was returned to the page
 > allocator.
 > 
 > >  This is the first time this box has had a problem like this.
 > >  While I can't rule out bad memory (I'll memtest86 it when I
 > >  get a chance to), I'm inclined to suspect a 2.6 kernel bug.
 > 
 > Could be a bug, but it'd be a damn unusual one.  I wouldn't rule out a
 > bitflip.

Confirmed, it was a HW issue. Please disregard the original problem report.

(A recent upgrade led to a combination of front side bus speed setting
and number of unregistered memory modules that the chipset couldn't quite
handle. Darn, I would have preferred it to have been a bad SIMM.)

/Mikael
