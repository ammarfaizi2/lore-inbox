Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTDGPoN (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTDGPoN (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:44:13 -0400
Received: from ns.suse.de ([213.95.15.193]:27920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263505AbTDGPoM (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:44:12 -0400
To: "Robert Williamson" <robbiew@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, aniruddha.marathe@wipro.com,
       ltp-list@lists.sourceforge.net
Subject: Re: Same syscall is defined to different numbers on 3 different archs(was Re: Makefile  issue)
References: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Apr 2003 17:54:39 +0200
In-Reply-To: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73vfxqxpz4.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert Williamson" <robbiew@us.ibm.com> writes:
> 
> Obviously, we could add additional code to check for the running arch and
> define the syscall accordingly, however I'm not sure this is the correct
> way to go.  I'm copying our list, as well as the kernel mailing list about
> this, because I "think" the system calls should be defined to the same
> numbers across all architectures....but I'm not positive.  BTW,  I attached

No. Linux has traditionally used different syscall numbers for different
architectures. The original ports (alpha etc.) always used the syscall numbers
of the "native" Unix, so the numbering was often completely different.
Newer ports who weren't concered about such compatibility often did 
a renumbering too. For example x86-64 has a completely new 
"cache line optimized" ordering.

What should work on most architectures is 
(most = someone told me it doesn't work properly on IA64)

#include </path/to/kernel/source/include/asm-<arch>/unistd.h>
(you need the version in the kernel source because many glibc packagers
in their infinite wisdom use an old outdated copy of asm/ usually from
the last stable kernel only) 

_syscallN(...) 

-Andi
