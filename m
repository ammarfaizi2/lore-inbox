Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289680AbSA2Oue>; Tue, 29 Jan 2002 09:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289667AbSA2OuX>; Tue, 29 Jan 2002 09:50:23 -0500
Received: from sun.fadata.bg ([80.72.64.67]:58631 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S289645AbSA2OuP>;
	Tue, 29 Jan 2002 09:50:15 -0500
To: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: pagecoloring: kernel 2.2 mm question: what is happening during fork ?
In-Reply-To: <11EB52F86530894F98FFB1E21F9972540C239A@aeoexc01.emea.cpqcorp.net>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
Date: 29 Jan 2002 16:43:19 +0200
In-Reply-To: <11EB52F86530894F98FFB1E21F9972540C239A@aeoexc01.emea.cpqcorp.net>
Message-ID: <87ofjdi5fc.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Cabaniols" == Cabaniols, Sebastien <Sebastien.Cabaniols@Compaq.com> writes:

Cabaniols> When I do a fork, which part of the kernel is allocating the memory for
Cabaniols> the childs, where and when the memory copy takes place ?

mm/memory.c:copy_page_range()

It copies page tables and marks the ptes copy-on-write.

Cabaniols> I know that
Cabaniols> linux is doing copy on write but I don't know which part of the kernel
Cabaniols> is really doing the page allocation when the copy on write understands
Cabaniols> that the process really wants to write now. Then the second question is
Cabaniols> how is the memory copy done ?

mm/memory.c: handle_mm_fault()/handle_pte_fault() and do_wp_page()

Cabaniols> The third and last question is what is the role of the slab allocator ?
Cabaniols> When does a process asks for memory from a slab ? Is it used to build
Cabaniols> the stack the heap ? 

Slab allocator is a memory allocation and caching mechanism for
(small) kernel objects. It is described in, e.g., 

    http://nondot.org/sabre/os/files/MemManagement/SlabAllocator.pdf

Regards,
-velco

PS. You may also find help on irc.openprojects.net, #kernelnewbies

