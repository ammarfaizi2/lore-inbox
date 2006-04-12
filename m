Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWDLRWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWDLRWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWDLRWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:22:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32406 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932271AbWDLRWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:22:41 -0400
To: Andi Kleen <ak@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain>
	<200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
	<4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com>
	<443B873B.9040908@sw.ru> <p73mzer4bti.fsf@bragg.suse.de>
	<443CA47E.4070809@sw.ru> <p73irpf473y.fsf@bragg.suse.de>
	<443CB181.40008@sw.ru> <p738xqa4tgj.fsf@bragg.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 12 Apr 2006 11:20:05 -0600
In-Reply-To: <p738xqa4tgj.fsf@bragg.suse.de> (Andi Kleen's message of "12
 Apr 2006 19:03:24 +0200")
Message-ID: <m1mzeq7ltm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Kirill Korotaev <dev@sw.ru> writes:
>> 
>> -------------- cut ---------------
>> Changing PAGE_OFFSET this way would break at least Valgrind (the latest
>> release 3.1.0 by default is statically linked at address 0xb0000000, and
>> PIE support does not seem to be present in that release).  I remember
>> that similar changes were also breaking Lisp implementations (cmucl,
>> sbcl), however, I am not really sure about this.
>> -------------- cut ---------------
>
> valgrind only breaks when you decrease TASK_SIZE to 2GB, not when you
> enlarge it. In general 2GB VM breaks a lot of apps, that is why
> the new CONFIGs that were added for this were a very bad idea imho.
>
> Obviously the x86-64 kernel doesn't support such things.
>
>> Also, why would one expect 4GB of VM on x86-64 if normally have 3GB on
>> i686? Anyway, as it is tunable, people can select which one they
>> prefer.
>
> Because near all programs that need can actually take advance of it.

So back to the core aim of this thread.

i386 -> x86_64: 32bit migration should work, but may be a little
confusing with the increase in VM space.  (I wonder how this
interacts with the kernels vdso).  

x86_64 -> i386 is likely to use addresses between 3GB and 4GB
and thus the migration probably will not work.  Unless the VM
accessible to user space is capped at 3G.

Odd.  But address space layout looks like one of the easiest migraion
problem to solve.

Eric

