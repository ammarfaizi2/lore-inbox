Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVLNKXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVLNKXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVLNKXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:23:45 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10916 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932295AbVLNKXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:23:43 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <15167.1134488373@warthog.cambridge.redhat.com>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 16:10:05 +0000
Message-Id: <1134490205.11732.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 15:39 +0000, David Howells wrote:
>  (3) Some people want mutexes to be:
> 
>      (a) only releasable in the same context as they were taken
> 
>      (b) not accessible in interrupt context, or that (a) applies here also
> 
>      (c) not initialisable to the locked state
> 
>      But this means that the current usages all have to be carefully audited,
>      and sometimes that unobvious.

Only if you insist on replacing them immediately. If you submit a
*small* patch which just adds the new mutexes then a series of small
patches can gradually convert code where mutexes are better. People will
naturally hit the hot and critical points first meaning that in a short
time the users of semaphores will be those who need it, and those who
are not critical to performance.

There is a problemn with init_MUTEX*/DECLARE_MUTEX naming being used for
semaphore struct init and I don't see a nice way to fix that either. I'd
rather see people just have to fix those as compiler errors (or a perl
-e regexp run to make them all init_SEM/DECLARE_SEM before any other
changes are made).


