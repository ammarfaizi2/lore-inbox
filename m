Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319478AbSH3H4c>; Fri, 30 Aug 2002 03:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319480AbSH3H4b>; Fri, 30 Aug 2002 03:56:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319478AbSH3H4b>;
	Fri, 30 Aug 2002 03:56:31 -0400
Message-ID: <3D6F28F6.71228222@zip.com.au>
Date: Fri, 30 Aug 2002 01:12:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
References: <Pine.LNX.4.44.0208300939030.8227-100000@localhost.localdomain> <Pine.LNX.4.44.0208300948320.8448-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> >  - changes the migration code to use struct completion. Andrew pointed out
> >    that there might be a small window in where the up() touches the
> >    semaphore while the waiting task goes on and frees its stack. And
> >    completion is more suited for this kind of stuff anyway.
> 
> actually, i think the race does not exist. up() is perfectly safely done
> on the on-stack semaphore, because both the wake_up() done by __up() and
> the __down() path takes the waitqueue spinlock, so i cannot see where the
> up() touches the semaphore after the down()-ed task has been woken up.
> 

yep, looks like the killing of the semaphore_lock made the race
go away.

But ia64, sparc and x86_64 use semaphore_lock, so they still are
exposed.
