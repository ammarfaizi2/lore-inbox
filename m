Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268054AbTBMO75>; Thu, 13 Feb 2003 09:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268055AbTBMO75>; Thu, 13 Feb 2003 09:59:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45416 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268054AbTBMO74>; Thu, 13 Feb 2003 09:59:56 -0500
To: suparna@in.ibm.com
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
References: <20030213161014.A14361@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Feb 2003 08:09:16 -0700
In-Reply-To: <20030213161014.A14361@in.ibm.com>
Message-ID: <m1heb8w737.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> Martin Bligh came up with a simple way to fix the kernel
> to enable kexec boot from any CPU. 
> 
> Rather than picking up boot cpu information from the MP 
> tables (which belong to the previous boot in the case of 
> kexec), it just sets it to the cpu its starting on.
> (See the changes in arch/i386/kernel/smpboot.c)
> 
> This simplifies the the kexec-hwfixes patch, since we
> no longer need to move to the boot cpu before stopping
> other processors. Which removes a lot of the unconditional
> patching of reboot.c and makes it less invasive, thanks to 
> Martin. Also, at panic time, cpu migration is something 
> that is best avoided.

I will agree with that, at least conditionally.  

I figure stop_apics can be removed from the panic path.

However stopping all of the cpus does seem to be something
that is needed on the panic path.  And if we stop cpus
what is wrong with cpu migration.  Or can we move the halt
of the cpus into the panic kernel?  That would be my real 
preference.

> It would be good if someone could test this out (on SMP)
> and confirm it works fine (I tried it on a 4way).
> 
> Eric, Do these changes look OK to you ? Did you have
> something similar in mind, when you were talking about
> enabling the kexec'd kernel to not care about which cpu
> it was running on ?

50%.  The normal case needs to shutdown the way it is currently doing.
So we need to audit the code a little more.

Basically the way I see it, in the normal case the kernel is responsible
for a clean shutdown of the kernel and all it's devices.   No one else
knows better how to accomplish those tasks then the drivers running the kernel.

On the other hand during a panic the recovery kernel is responsible for
everything it possibly can handle.  Because we know something is broken
in the kernel calling kexec.

Eric
