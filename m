Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRGIVDh>; Mon, 9 Jul 2001 17:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264937AbRGIVD1>; Mon, 9 Jul 2001 17:03:27 -0400
Received: from ns.suse.de ([213.95.15.193]:16658 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264932AbRGIVDM>;
	Mon, 9 Jul 2001 17:03:12 -0400
To: Adam Shand <larry@spack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Jul 2001 23:03:11 +0200
In-Reply-To: Adam Shand's message of "9 Jul 2001 22:05:47 +0200"
Message-ID: <oup66d1g6i8.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Shand <larry@spack.org> writes:

> 
>  * And, what (if any) paramaters can effect this (recompiling the app
>    etc)?

The kernel parameter is a constant called __PAGE_OFFSET which you can set.
You also need to edit arch/i386/vmlinux.lds

The reason why your simulation stopped at 2.3GB is likely that the malloc
allocation hit the shared libraries (check with /proc/<pid>/maps). Ways
around that are telling malloc to use mmap more aggressively (see the
malloc documentation in info libc) or moving the shared libraries up 
by changing a kernel constant called TASK_UNMAPPED_BASE. 

-Andi

