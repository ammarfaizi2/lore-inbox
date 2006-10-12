Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbWJLGvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWJLGvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbWJLGvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:51:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40162 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161260AbWJLGvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:51:41 -0400
Subject: Re: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rusty@rustcorp.com.au
In-Reply-To: <17709.33386.884615.679131@cse.unsw.edu.au>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	 <6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	 <17708.33450.608010.113968@cse.unsw.edu.au>
	 <6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
	 <1160565786.3000.369.camel@laptopd505.fenrus.org>
	 <17708.60613.451322.747200@cse.unsw.edu.au>
	 <20061011093920.32fc2d07.akpm@osdl.org>
	 <17709.33386.884615.679131@cse.unsw.edu.au>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 08:51:12 +0200
Message-Id: <1160635872.3000.399.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 09:46 +1000, Neil Brown wrote:
> On Wednesday October 11, akpm@osdl.org wrote:
> > > 
> > > So A waits on B and C, C waits on B, B waits on A.
> > > Deadlock.
> > 
> > Except the entire operation is serialised by the the two top-level callers
> > (cpu_up() and cpu_down()) taking mutex_lock(&cpu_add_remove_lock).  Can
> > lockdep be taught about that?
> 
> So you are saying that even though we have locking sequences
>   A -> B  and B -> A,
> that cannot - in this case - cause a deadlock as both sequences only
> ever happen under a third exclusive lock C,
> So when lockdep records a lock-dependency A -> B, it should also
> record a list of locks that are *always* held when that dependency
> occurs.

in that case... why are A and B there *at all* ?


