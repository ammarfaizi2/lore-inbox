Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWDMXCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWDMXCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWDMXCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:02:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56297 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751171AbWDMXCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:02:37 -0400
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Bonachea <bonachead@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <6.2.5.6.2.20060413145913.03436f38@comcast.net>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
	 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au>
	 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
	 <1144965022.12387.23.camel@localhost.localdomain>
	 <6.2.5.6.2.20060413145913.03436f38@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 00:11:47 +0100
Message-Id: <1144969908.12387.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-04-13 at 15:06 -0700, Dan Bonachea wrote:
> Unless I'm missing something, that doesn't leave much ambiguity regarding 
> what's required for POSIX compliance on this issue (although I'm not sure 
> POSIX compliance is the right metric).

Interesting. That pretty much conflicts with what write(2) itself is
defined as in the same specification, and means that the locking is
specific to posix thread groups not to processes. Well we've always
known that pthreads was a brain dead screw-up of a specification so I
guess that should be no suprise.

If the locking is thread group specific it may actually be best to
handle that one in glibc with a futex lock, as only glibc really knows
what is a posix pthread app, and it would avoid the idiocy escaping into
normal applications (which are 95+% of cases)

What does Ulrich think ?


Alan

