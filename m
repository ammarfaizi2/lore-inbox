Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271710AbTGYFNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 01:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271924AbTGYFNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 01:13:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53633
	"EHLO x30.random") by vger.kernel.org with ESMTP id S271710AbTGYFNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 01:13:19 -0400
Date: Fri, 25 Jul 2003 01:28:18 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030725052818.GA6440@x30.random>
References: <200307231521.15897.rathamahata@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307231521.15897.rathamahata@php4.ru>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:21:15PM +0400, Sergey S. Kostyliov wrote:
> Hello Andrea,
> 
> This is during `swapoff -a`, on a heavily loaded box:
> 
> ksymoops 2.4.9 on i686 2.4.22-pre6aa1.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.22-pre6aa1/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
> ksymoops: No such file or directory
> kernel BUG at shmem.c:490!

hmm, 2.4.22pre6aa1 was the first 2.4 largepages port to the >=22pre
shmfs backport from 2.5. It could be a bug in 2.5, or a bug present only
in the backport of the 2.5 code to 22pre, or even a bug only present in
-aa due the largepage patch ported on top of the backport included in
22pre. I'll have a closer look at it tomorrow. The place where it
crashed is:

	BUG_ON(inode->i_blocks);

it might be only a minor accounting issue. It needs some auditing.

I'm afraid you're the first one testing the shmfs backport in 22pre +
the largepage support patch in my tree with a big app doing swapoff at
the same time.

Are you using bigpages btw?

thank you very much for the feedback,

Andrea

PS. shall this give us relevant problems in the debugging/auditing, I'll
just give you a patch to backout the backport and go back to the shmfs
code in 2.4.21rc8aa1 that is running rock solid in production with
largepages (I doubt you need the loop device on top of shmfs anyways). I
prefer not to spend much time on new 2.4 features.
