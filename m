Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSEWV5L>; Thu, 23 May 2002 17:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317027AbSEWV5K>; Thu, 23 May 2002 17:57:10 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:23801 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317026AbSEWV5I>; Thu, 23 May 2002 17:57:08 -0400
Date: Thu, 23 May 2002 17:57:08 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@redhat.com
Subject: Re: [PATCH] 2.4.19-pre8 vm86 smp locking fix
Message-ID: <20020523175708.A29031@redhat.com>
In-Reply-To: <20020523165105.A27881@redhat.com> <3CED60D7.9E5032D7@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 11:36:23PM +0200, Kasper Dupont wrote:
> The pagetable access in arch/i386/kernel/vm86.c is related
> to another access in arch/i386/mm/fault.c. Did anybody
> verify that the other file does correct locking?

That should be safe: the vmalloc pgds can only be filled from the 
main kernel page table.  They never change afterwards, so even if 
two CPUs entered that code at the same time it would be okay.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
