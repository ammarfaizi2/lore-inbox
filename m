Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbUDGELL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 00:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUDGELL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 00:11:11 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:31908 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262920AbUDGELI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 00:11:08 -0400
Message-ID: <40737F5C.3050708@yahoo.com.au>
Date: Wed, 07 Apr 2004 14:11:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Srivatsa Vaddagiri <vatsa@in.ibm.com>, rusty@au1.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
 CPU_DEAD handling
References: <20040405121824.GA8497@in.ibm.com>	 <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com>	 <407277AE.2050403@yahoo.com.au> <1081310073.5922.86.camel@bach>
In-Reply-To: <1081310073.5922.86.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Tue, 2004-04-06 at 19:26, Nick Piggin wrote:
> 
>>Note there was already that check in the wakeup path, although
>>I suspect it was someone being overly cautious and isn't required.
> 
> 
> No, it really is required.
> 
> The stop_machine thread runs on the cpu, then kicks everyone else off,
> then does a complete() (in stop_machine.c:do_stop()).  Without this
> check, the complete() drags the sleeping process (which called
> stop_machine) onto the dying CPU.
> 
> Hmm, maybe we could explicitly exclude downed cpu from calling task's
> mask.  Kind of hacky: theoretically you should never modify a task's
> affinity unless the user actually asked for it (since anyone can ask for
> another tasks affinity).
> 

Ahh yeah ok. Well it seems this isn't required with Srivatsa's
patch though, although it would be required again if my lazy
migrate patch were to go on top of that.

In that case, I'm happy with moving migrate_all_tasks to
CPU_DEAD handling, and keeping the lazy migrate patch out of
the tree.
