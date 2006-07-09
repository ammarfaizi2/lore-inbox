Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWGIVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWGIVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWGIVG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:06:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22188 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161151AbWGIVG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:06:27 -0400
Subject: Re: 2.6.18-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060709035203.cdc3926f.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com>
	 <20060709035203.cdc3926f.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 23:06:24 +0200
Message-Id: <1152479184.3255.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 03:52 -0700, Andrew Morton wrote:
> On Sun, 9 Jul 2006 12:32:27 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
> > Hi,
> > 
> > On 09/07/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> > >
> > 
> > This looks like a problem with cpufreq.
> > 
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > -------------------------------------------------------
> > cpuspeed/1426 is trying to acquire lock:
> >  (&inode->i_data.tree_lock){.+..}, at: [<c0151dc7>] find_get_page+0x12/0x70
> > 
> > but task is already holding lock:
> >  (&mm->mmap_sem){----}, at: [<c0116cab>] do_page_fault+0x10d/0x4ea
> > 
> > which lock already depends on the new lock.
> > 
> 
> rofl.  You broke lockdep.
> 
> Well.  I guess it's barely conceivable that you earlier took an oops while
> holding tree_lock, so lockdep decided that mmap_sem nests inside tree_lock.

I think it would be justified to disable lockdep in an oops; after all
the kernel state can't really be trusted once that happen.... 

