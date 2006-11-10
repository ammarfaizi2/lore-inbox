Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946371AbWKJKhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946371AbWKJKhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWKJKhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:37:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932839AbWKJKhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:37:16 -0500
Date: Fri, 10 Nov 2006 11:36:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061110103650.GE3196@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611091652.34649.rjw@sisk.pl> <20061109160003.GA24156@elf.ucw.cz> <200611092059.48722.rjw@sisk.pl> <20061109211722.GA2616@elf.ucw.cz> <1163154249.7900.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163154249.7900.19.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> > Why not simply &~ PF_NOFREEZE on that particular process? Filesystems
> > are free to use threads/work queues/whatever, but refrigerator should
> > mean "no writes to filesystem" for them...
> 
> You can't go around altering the flags of another process - what locking
> are you relying upon for this ?

Well, my idea was for process to &~ PF_NOFREEZE on itself.

We are currently (kernel/power/process.c) using &p->sighand->siglock
for some accesses, and no locking for others. There were some attempts
to fix this, but they led to problems, and we are not hitting any
problems... part of reason is that we hot-unplug non-boot cpus before
freezing processes, so we are running UP at that point.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
