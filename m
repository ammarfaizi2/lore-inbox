Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269009AbTCAT7B>; Sat, 1 Mar 2003 14:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269014AbTCAT7B>; Sat, 1 Mar 2003 14:59:01 -0500
Received: from dp.samba.org ([66.70.73.150]:9704 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269009AbTCAT67>;
	Sat, 1 Mar 2003 14:58:59 -0500
Date: Sat, 1 Mar 2003 20:12:24 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: sfr@canb.auug.org.au, davem@redhat.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, matthew@wil.cx, ralf@gnu.org,
       schwidefsky@de.ibm.com, torvalds@transmeta.com
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Message-ID: <20030301091224.GE2606@krispykreme>
References: <200302280950.h1S9oZdx014060@supreme.pcug.org.au> <20030228103609.GA29955@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228103609.GA29955@averell>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now there used to be some code that did:
> 
> 	if (get_user(a, &userstruct->firstmember) ||
> 	   __get_user(b, &userstruct->secondmember))
> 		return -EFAULT;
> 
> Assuming that the access_ok in get_user for sizeof(firstmember) covers
> secondmember too which doesn't do access_ok in __get_user. This only
> works assuming it should handle 64bit pointers when there is a memory
> hole at the end of the user process space, otherwise it could
> access kernel pages directly after TASK_SIZE. x86-64 has a big enough 
> hole there, i assume sparc64 and ia64 have too, but i don't know 
> about the other 64bit ports.

Yeah there are a bunch of those in the ioctl and syscall translation
code that annoys me. ppc64 is safe too, but its not something we should
rely on.

Anton
