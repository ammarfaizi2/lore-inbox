Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRHQO0c>; Fri, 17 Aug 2001 10:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271665AbRHQO0W>; Fri, 17 Aug 2001 10:26:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38395 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271664AbRHQO0D>;
	Fri, 17 Aug 2001 10:26:03 -0400
Date: Fri, 17 Aug 2001 09:26:10 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Terje Eggestad <terje.eggestad@scali.no>, Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] processes with shared vm
Message-ID: <36530000.998058370@baldur>
In-Reply-To: <998038019.7627.21.camel@pc-16.office.scali.no>
In-Reply-To: <997973469.7632.10.camel@pc-16.suse.lists.linux.kernel>
 <oupelqbw0z4.fsf@pigdrop.muc.suse.de>
 <998038019.7627.21.camel@pc-16.office.scali.no>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, August 17, 2001 10:46:59 +0200 Terje Eggestad 
<terje.eggestad@scali.no> wrote:

> hought of all that, yes ps will have O(n^2) BUT ONLY FOR CLONED PROCS.
> How many cloned procs do you usually have????
>
> Even if I agree that there should be a linked list of all the cloned
> procs, it means major changes to the data structs in the kernel.
>
> With the number of threaded programs out there, this is "good enough".

There is a simpler way to do this.  All tasks belong to a thread group, and 
while thread groups are connected via a different clone flag 
(CLONE_THREAD), in practice CLONE_THREAD and CLONE_VM are generally used 
together.  It would be trivial to add TGID to the information in /proc, 
then assume all tasks with the same TGID have the same VM as well.  It 
would be just one more line in the /proc output and not require any 
additional overhead.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

