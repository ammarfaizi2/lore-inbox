Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281473AbRLGODO>; Fri, 7 Dec 2001 09:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281483AbRLGODF>; Fri, 7 Dec 2001 09:03:05 -0500
Received: from ns.suse.de ([213.95.15.193]:55563 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281322AbRLGOCv>;
	Fri, 7 Dec 2001 09:02:51 -0500
To: Paul Sargent <Paul.Sargent@3dlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2GB process crashing on 2.4.14
In-Reply-To: <20011207125821.D31161@3dlabs.com.suse.lists.linux.kernel> <E16CKrx-0005nL-00@the-village.bc.nu.suse.lists.linux.kernel> <20011207132317.E31161@3dlabs.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Dec 2001 15:02:46 +0100
In-Reply-To: Paul Sargent's message of "7 Dec 2001 14:27:04 +0100"
Message-ID: <p73k7vz6sc9.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Sargent <Paul.Sargent@3dlabs.com> writes:


> So if I was hitting this limit then I should see no / very few gaps, in the
> /proc/<pid>/maps. Is that true?

It usually fails when malloc() hits your libraries. One solution is to
recompile the kernel with a higher TASK_UNMAPPED_BASE (should be a sysctl,
but is a fixed define currently). That would force the shared libraries 
to start at a higher address and give sbrk() more breathing space.

Another way is to use mallopt(M_MMAP_THRESHOLD, ..)  and set a low mmap
threshold. This allows malloc to use mmap earlier instead of sbrk() and skip
the shared library area.  It comes at a cost thought, malloc() tends to 
become more expensive.

With some more changes you can also force the user space to 3.5GB, at the
cost of much less kernel memory. It usually makes sense to change 
TASK_UNMAPPED_BASE with this.

-Andi

P.S.: I'm pretty sure this is a FAQ.
