Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVETUNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVETUNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVETUNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:13:00 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:48343 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261570AbVETUM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:12:56 -0400
Date: Fri, 20 May 2005 16:12:55 -0400
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
Message-ID: <20050520201255.GG23621@csclub.uwaterloo.ca>
References: <428CD458.6010203@free.fr> <20050520125511.GC23488@csclub.uwaterloo.ca> <428DF95E.2070703@free.fr> <20050520165307.GG23488@csclub.uwaterloo.ca> <d6l9cs$l1t$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6l9cs$l1t$1@news.cistron.nl>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 06:13:48PM +0000, Miquel van Smoorenburg wrote:
> No. On modern systems, glibc contains both LinuxThreads and NPTL.
> They have the same ABI. At runtime one of the two is selected,
> depending on if the currently running kernel supports NTPL.
> You can also force it by setting the LD_ASSUME_KERNEL environment
> variable to 2.4 or 2.6.

Well so far my tests show that glibc 2.3.2.ds1-21 on Debian Sarge when
running 2.6.11 kernel on i386 uses LinuxThreads, while on amd64 version
of Sarge it uses NPTL (and won't run with 2.4 kernel at all either).

Maybe Debian compiled their glibc to not do NPTL on i386 yet.  Not sure.

Hmm, after checking, it turns out if you use errno in your program, it
drops to linuxthreads, while using #include <errno.h> makes it able to
use NPTL when using 2.6 kernel.  Now my program works the same on i386
as on amd64 (I had to fix the errno to make it run on amd64 so that does
make some sense).  Well I learned something new.

Len Sorensen
