Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVELH55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVELH55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 03:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVELH55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 03:57:57 -0400
Received: from ns.itc.it ([217.77.80.3]:25229 "EHLO mail.itc.it")
	by vger.kernel.org with ESMTP id S261289AbVELH5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 03:57:36 -0400
Date: Thu, 12 May 2005 10:00:20 +0200
From: Fabio Brugnara <brugnara@itc.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Fabio Brugnara <brugnara@itc.it>, linux-kernel@vger.kernel.org
Subject: Re: problem with mmap over nfs
Message-ID: <20050512080020.GJ21293@maestoso.itc.it>
References: <20050506095023.GS9742@maestoso.itc.it> <20050506045446.1deba35d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506045446.1deba35d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 04:54:46AM -0700, Andrew Morton wrote:
>
> Could you please generate a kernel profile?
>
> - Compile with CONFIG_PROFILING
>
> - Start the workload, wait for steady state.
>
> - As root, run:
>
> #!/bin/sh
>
> SM=/boot/System.map
> TIMEFILE=/tmp/prof.time
> readprofile -r
> sleep 10
> readprofile -n -v -m $SM | sort -n +2 | tail -40 | tee $TIMEFILE >&2
>
> (make sure that /boot/System.map is from the currently-running kernel)
>
> More in Documentation/basic_profiling.txt
>
>
>
> Even better, learn to drive oprofile.  Once it's running properly I usually
> use this silly script:
>
> #!/bin/sh
> opcontrol --stop
> opcontrol --shutdown
> rm -rf /var/lib/oprofile
> opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
> opcontrol --start-daemon
> opcontrol --start
> sleep 10
> opcontrol --stop
> opcontrol --shutdown
> opreport -l /boot/vmlinux-$(uname -r) | head -50

Hi Andrew,

The short story:

Alarm is over. Everything works perfectly with 2.6.11.

The long story:

I could not directly do what was suggested, so I went for help to one of
our sysadmin. He installed oprofile and everything, but discovered that we
could not use it, because we didn't have the vmlinux image of the running
kernel, only vmlinuz.  After trying to recover vmlinux from vmlinuz and
discovering that it's not possible, he decided to recompile the kernel.
But, since now 2.6.11 is released, he decided also to try the latest
version.  Well, when running under 2.6.11 the strange phenomenon of
excessive system usage does not appear anymore. What we observed was
therefore just another symptom of some bug (who knows what ... ) that was
already known and fixed.

best regards,
thank you again for your attention,
Fabio

PS: just to be precise:

the kernel that had the problem was:

$ uname -r
2.6.10-1.741_FC3smp

the kernel that is now working well is:

$ uname -r
2.6.11-1.14.RH9smp

