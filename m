Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWADWYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWADWYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWADWYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:24:31 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:47338 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030300AbWADWY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:24:29 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: gcoady@gmail.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Date: Thu, 05 Jan 2006 09:24:24 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <3nior1hr32amav20nvo5qua7jnvsqaj69h@4ax.com>
References: <20060104145138.GN3831@stusta.de> <35dor152f8ehril7qh22oi8sgkjdohd9jv@4ax.com> <20060104210045.GV3831@stusta.de>
In-Reply-To: <20060104210045.GV3831@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 22:00:45 +0100, Adrian Bunk <bunk@stusta.de> wrote:

>On Thu, Jan 05, 2006 at 07:53:00AM +1100, Grant Coady wrote:
>> On Wed, 4 Jan 2006 15:51:38 +0100, Adrian Bunk <bunk@stusta.de> wrote:
>>...
>> > 	  If you say Y here the kernel will use a 4Kb stacksize for the
>> > 	  kernel stack attached to each process/thread. This facilitates
>> 
>> Perhaps mention 4k + 4k stacks, the separate irq stacks used with 4k option?  
>
>Feel free to submit a patch.  ;-)

Okay :)


Based on Adrian Bunk's patch, default to 4k +4k stacks and making 
it more obvious that available stack space is not being halved.
Compile tested.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 Kconfig.debug |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.15a/arch/i386/Kconfig.debug	2005-10-28 10:02:08.000000000 +1000
+++ linux-2.6.15b/arch/i386/Kconfig.debug	2006-01-05 09:39:22.000000000 +1100
@@ -53,14 +53,15 @@
 	  of memory corruptions.
 
 config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
-	depends on DEBUG_KERNEL
+	bool "Use 4Kb + 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
+	default y
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
 	  kernel stack attached to each process/thread. This facilitates
 	  running more threads on a system and also reduces the pressure
 	  on the VM subsystem for higher order allocations. This option
-	  will also use IRQ stacks to compensate for the reduced stackspace.
+	  will also use separate 4Kb IRQ stacks to compensate for the 
+	  reduced stackspace.
 
 config X86_FIND_SMP_CONFIG
 	bool
