Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUFCXCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUFCXCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUFCXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:02:24 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:14750 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264623AbUFCXCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:02:18 -0400
Message-ID: <40BFADE5.9040506@myrealbox.com>
Date: Thu, 03 Jun 2004 16:01:57 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, mingo@elte.hu
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       arjanv@redhat.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu>	<Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>	<20040603072146.GA14441@elte.hu>	<20040603124448.GA28775@elte.hu> <20040603175422.4378d901.ak@suse.de>
In-Reply-To: <20040603175422.4378d901.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, 3 Jun 2004 14:44:48 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
> 
>>- in exec.c, since address-space executability is a security-relevant
>>item, we must clear the personality when we exec a setuid binary. I
>>believe this is also a (small) security robustness fix for current
>>64-bit architectures.
> 
> 
> I'm not sure I like that. This means I cannot earily force an i386 uname 
> or 3GB address space on suid programs anymore on x86-64.
> 
> While in theory it could be a small security problem I think the utility
> is much greater.
> 
> It's hard to see how setting NX could cause a security hole. The program
> may crash, but it is unlikely to be exploitable.

The whole point of NX, though, is that it prevents certain classes of 
exploits.  If a setuid binary is vulnerable to one of these, then Ingo's 
patch "fixes" it.  Your approach breaks that.

I don't like Ingo's fix either, though.  At least it should check 
CAP_PTRACE or some such.  A better fix would be for LSM to pass down a flag 
indicating a change of security context.  I'll throw that in to my 
caps/apply_creds cleanup, in case that ever gets applied.

--Andy


> 
> -Andi

