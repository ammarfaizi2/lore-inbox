Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129635AbRBXVzP>; Sat, 24 Feb 2001 16:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbRBXVzG>; Sat, 24 Feb 2001 16:55:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49668 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129635AbRBXVyz>; Sat, 24 Feb 2001 16:54:55 -0500
Subject: Re: Core dumps for threads
To: n0ano@valinux.com (Don Dugger)
Date: Sat, 24 Feb 2001 21:57:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010224134523.O26109@valinux.com> from "Don Dugger" at Feb 24, 2001 01:45:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WmhG-0000Yj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anyone explain why this test is in routine `do_coredump'
> in file `fs/exec.c' in the 2.4.0 kernel?
> 
>     if (!current->dumpable || atomic_read(&current->mm->mm_users) != 1)
> 	goto fail;
> 
> The only thing the test on `mm_users' seems to be doing is stopping
> a thread process from dumping core.  What's the rationale for this?

The I/O to dump the core would race other changes on the mm. The right fix
is probably to copy the mm (as fork does) then dump the copy.

