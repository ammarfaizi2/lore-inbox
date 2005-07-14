Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVGNMjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVGNMjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVGNMjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:39:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261343AbVGNMjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:39:44 -0400
Date: Thu, 14 Jul 2005 08:39:17 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rvk@prodmail.net, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thread_Id
Message-ID: <20050714123917.GE4884@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it> <42CB465E.6080104@shaw.ca> <42D5F934.6000603@prodmail.net> <1121327103.3967.14.camel@laptopd505.fenrus.org> <42D63916.7000007@prodmail.net> <1121337052.3967.25.camel@laptopd505.fenrus.org> <42D64A85.7020305@prodmail.net> <1121343943.3967.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121343943.3967.32.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 02:25:43PM +0200, Arjan van de Ven wrote:
> pure luck. NPTL threading uses it to store a pointer to per thread info
> structure; other threading (linuxthreads) may have stored a pid there to
> identify the internal thread. nptl is 2.6 only so you might have
> switched implementation of threading when you switched kernels.

Actually, in linuxthreads what pthread_self () returned has the first slot
in its internal threads array (up to max number of supported threads)
that was unused at thread creation time in the low order bits and sequence
number of thread creation in its high order bits.
So unless you are using yet another threading library (I thought NGPT
is dead for years...), the claim that you get the same numbers from
gettid() syscall under NPTL as pthread_self () gives you under LinuxThreads
is simply not true.  And you certainly shouldn't be using gettid ()
syscall in NPTL, as it is just an implementation detail that there is
a 1:1 mapping between NPTL threads and kernel threads.  It can change
at any time.

	Jakub
