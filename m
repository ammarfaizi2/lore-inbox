Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbRAXVbz>; Wed, 24 Jan 2001 16:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRAXVbo>; Wed, 24 Jan 2001 16:31:44 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:51954 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129786AbRAXVbi>; Wed, 24 Jan 2001 16:31:38 -0500
Date: Wed, 24 Jan 2001 15:31:37 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Cc: Linux MM mailing list <linux-mm@kvack.org>
In-Reply-To: <3A6F45F4.8020004@valinux.com>
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org> <20010124203012Z129444-18594+1042@vger.kernel.org> 
	<20010124204811Z129375-18594+1059@vger.kernel.org>
Subject: Re: Page Attribute Table (PAT) support?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010124213139Z129786-18594+1082@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Wed, 24 Jan
2001 14:15:32 -0700


> Pages with multiple mappings aren't really supported by the Intel ia32 
> architecture.  The trick you do above works, but is strongly discouraged 
> by the Intel documentation.  The documentation says that if you do this 
> with UCWC memory, it won't work (and will result in undefined processor 
> behavior.)  My experiments with the PAT seem to agree with the 
> documentation.

Is it still a problem even we never access the memory through the non-UCWC
memory? 

> 	We have to remove the kernel page table mappings.  (Convert the 4MB pages 
> to individual pte's, then change the individual pte so its pgprot value 
> is correct.)

That sounds like an incredible amount of work!  Are you going to support this
in your code?  I wouldn't even know how to begin implementing that.

> 	When you allocate memory in the kernel, you OWN it.  Its not mapped into 
> a user space process unless you put it there.  I have to point out that 
> this interface requires the user to insure these pages are never ever 
> swapped, or mapped cached.  This isn't a huge restriction, since we 
> aren't providing a user land interface.  If we try to handle all/some of 
> these cases in the kernel, it becomes a very large problem.  We would 
> have to add arch specific bits for special cache handling, Do smp cache 
> flushes all over the place, etc.  Its really not worth it.

Ok, so what are you going to provide?  All I need is a method to access a
particular physical page, whether it's part of real RAM or not, in an UCWC
manner.  Can you give me a hint as to how that cability can be provided?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
