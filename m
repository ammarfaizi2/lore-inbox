Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUFCXzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUFCXzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUFCXzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:55:10 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:32428 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264902AbUFCXyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:54:54 -0400
Message-ID: <40BFBA3F.4000304@myrealbox.com>
Date: Thu, 03 Jun 2004 16:54:39 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, arjanv@redhat.com, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu> <20040603124448.GA28775@elte.hu> <20040603175422.4378d901.ak@suse.de> <40BFADE5.9040506@myrealbox.com> <20040603230834.GF868@wotan.suse.de>
In-Reply-To: <20040603230834.GF868@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>The whole point of NX, though, is that it prevents certain classes of 
>>exploits.  If a setuid binary is vulnerable to one of these, then Ingo's 
>>patch "fixes" it.  Your approach breaks that.
> 
> 
> Good point.
> 
> But that only applies to the NX personality bit. For the uname emulation
> it is not an issue.
> 
> So maybe the dropping on exec should only zero a few selected 
> personality bits, but not all.

True.

>>I don't like Ingo's fix either, though.  At least it should check 
>>CAP_PTRACE or some such.  A better fix would be for LSM to pass down a flag 
>>indicating a change of security context.  I'll throw that in to my 
>>caps/apply_creds cleanup, in case that ever gets applied.
> 
> 
> Don't think we should require an LSM module for that. That's 
> far overkill.

I'm not suggesting a new LSM module.  I'm suggesting modifying the existing 
LSM code to handle this cleanly.  We already have a function 
(security_bprm_secureexec) that does something like this, and, in fact, 
it's probably the right thing to test here.

I'm currently compiling a new patch (modified from my last caps cleanup) 
that makes a new bitfield for this stuff.  I don't know if it's worth 
applying, but I'll send it off to Andrew once I convince myself it works.

--Andy

