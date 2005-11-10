Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVKJHkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVKJHkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVKJHkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:40:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:15595 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751263AbVKJHkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:40:23 -0500
Message-ID: <4372F95E.3070107@pobox.com>
Date: Thu, 10 Nov 2005 02:40:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: openat()
References: <43724AB3.40309@redhat.com> <Pine.LNX.4.63.0511091338200.728@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.63.0511091338200.728@twinlark.arctic.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> On Wed, 9 Nov 2005, Ulrich Drepper wrote:
> 
> 
>>Can we please get the openat() syscall implemented?  I know Linus already
>>declared this is a good idea and I can only stress that it is really essential
>>for some things.  It is today impossible to write correct code which uses long
>>pathnames since all these operations would require the use of chdir() which
>>affect the whole POSIX process and not just one thread.  In addition we have
>>the reduction of race conditions.
> 
> 
> oh sweet i've always wanted this for perf improvements in multithreaded 
> programs which have to deal with lots of lookups deep in a directory tree 
> (especially over NFS).
> 
> would this include other related syscalls such as link, unlink, rename, 
> chown, chmod... so that the the virtualization of the "current working 
> directory" concept is more complete?

You already have fchown(2) and fchmod(2), that's covered.

I'm interested in openat(2) for the race-free implications.  I've been 
working on a race-free coreutils replacement[1], targetted mainly at 
Linux.  Being able to key an operation off of an open file descriptor 
eliminates the few remaining races inherent in the Linux filesystem ABI.

The remaining race cases are all cases where the the syscall takes a 
pathname, when it really should take a pathname and an fd.

	Jeff



