Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283045AbRLMCeB>; Wed, 12 Dec 2001 21:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283052AbRLMCdv>; Wed, 12 Dec 2001 21:33:51 -0500
Received: from cp1s4p1.dashmail.net ([216.36.32.37]:18181 "EHLO sr71.net")
	by vger.kernel.org with ESMTP id <S283045AbRLMCdp>;
	Wed, 12 Dec 2001 21:33:45 -0500
Message-ID: <3C18137E.78A6FF0A@sr71.net>
Date: Wed, 12 Dec 2001 18:33:34 -0800
From: "David C. Hansen" <dave@sr71.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
In-Reply-To: <3C17F8B2.6080700@us.ibm.com> <E16EKFr-000305-00@phalynx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming wrote:
> On December 12, 2001 16:39, David C. Hansen wrote:
> > We can add a semaphore which must be acquired before a module can be
> > unloaded, and hold it over the area where the module must not be
> > unloaded.  We could replace the unload_lock spinlock with a semaphore,
> > which I'll call it unload_sem here.  It would look something like this:
> Why not use a read-write semaphore? The sections that require the module to
> stay resident use a read lock, and module unloading aquires a write lock. In
> addition to containing the evil, evil BKL, you might actually get a tangiable
> scalability gain out of it.
Cool idea.  I'll do that.  Now that we have those locking primitives in
the kernel I wish that we used them more often. 
-- 
David C. Hansen
dave@sr71.net
