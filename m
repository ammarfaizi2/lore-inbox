Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWIRQY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWIRQY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWIRQY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:24:56 -0400
Received: from gw.goop.org ([64.81.55.164]:57771 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751826AbWIRQYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:24:55 -0400
Message-ID: <450EC855.6020200@goop.org>
Date: Mon, 18 Sep 2006 09:24:53 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, bcrl@kvack.org,
       Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Chris Wright <chrisw@sous-sol.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: Sysenter crash with Nested Task Bit set
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com> <20060917222537.55241d19.akpm@osdl.org> <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org> <200609181729.23934.ak@suse.de> <Pine.LNX.4.64.0609180841520.4388@g5.osdl.org> <Pine.LNX.4.64.0609180904360.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609180904360.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Final note (I promise): now that we save/restore eflags again, we 
> should probably revert the set_iopl_mask() in task switching too. However, 
> that apparently has some para-virtualization issues, so I'm going to 
> ignore that part from now.
>   

I'm wondering if we shouldn't have a (__)switch_to paravirt hook, so we 
can wrap the context switch in whatever we like.

> However, I'd really like people who know and care about the 
> paravirtualization to take a good long look at it: because right now, with 
> the addition of the eflags save/restore, the set_iopl_mask() in 
> __switch_to() is entirely useless for non-virtualized environments, afaik.
>   

Hm.  Zach removed the pushf/popf in switch_to this last Sept, with the 
comment "The pushf/popf in switch_to are ONLY used to switch IOPL. 
Making this explicit in C code is more clear.  This pushf/popf pair was 
added as a bugfix for leaking IOPL to unprivileged processes when using 
sysenter/sysexit based system calls (sysexit does not restore flags)."


> Zack added to the cc. Who else needs to know?
Rusty, Chris Wright and me.

