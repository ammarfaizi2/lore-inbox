Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWIRQLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWIRQLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWIRQLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:11:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751016AbWIRQLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:11:01 -0400
Date: Mon, 18 Sep 2006 09:10:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, bcrl@kvack.org,
       Zachary Amsden <zach@vmware.com>
Subject: Re: Sysenter crash with Nested Task Bit set
In-Reply-To: <Pine.LNX.4.64.0609180841520.4388@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609180904360.4388@g5.osdl.org>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com>
 <20060917222537.55241d19.akpm@osdl.org> <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org>
 <200609181729.23934.ak@suse.de> <Pine.LNX.4.64.0609180841520.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Sep 2006, Linus Torvalds wrote:
> 
> The addition is fairly obvious, but maybe I screwed something up, so buyer 
> beware...

Final note (I promise): now that we save/restore eflags again, we 
should probably revert the set_iopl_mask() in task switching too. However, 
that apparently has some para-virtualization issues, so I'm going to 
ignore that part from now.

However, I'd really like people who know and care about the 
paravirtualization to take a good long look at it: because right now, with 
the addition of the eflags save/restore, the set_iopl_mask() in 
__switch_to() is entirely useless for non-virtualized environments, afaik.

Zack added to the cc. Who else needs to know?

		Linus
