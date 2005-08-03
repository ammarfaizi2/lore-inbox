Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVHCMVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVHCMVB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVHCMUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:20:53 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57729 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262258AbVHCMTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:19:07 -0400
Subject: Re: [Question] arch-independent way to differentiate between user
	and kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
In-Reply-To: <20050803104856.GA10118@elte.hu>
References: <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123065472.1590.84.camel@localhost.localdomain>
	 <20050803104856.GA10118@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 03 Aug 2005 08:18:48 -0400
Message-Id: <1123071528.1590.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 12:48 +0200, Ingo Molnar wrote:
> 
> i dont think there's any. user_mode(regs) gets the closest - it might 
> make sense to generalize it over all arches.
> 
> update_process_times() gets an arch-independent 'was the tick user-space 
> or kernel-space' flag, so the best starting point would be to look at 
> the output of:
> 
>  for N in `find . -name '*.c' | xargs grep update_process_times |
>   grep arch`; do echo $N; done | grep update_process_times |
>    sort | uniq -c
> 
> which gives:
> 
>       2 update_process_times()
>       1 update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)),
>       6 update_process_times(user);
>       1 update_process_times(user_mode(fp));
>      33 update_process_times(user_mode(regs));
>       2 update_process_times(user_mode_vm(regs));
> 
> so ~33 calls use user_mode(regs), and the rest needs to be reviewed and 
> possibly changed. Looks doable.

Ingo,

Thanks for the starting point. For now I'll submit a patch that doesn't
do the user_mode checks as discussed before. Then if I can find
something here, I'll send another patch on top of the first patch later.

-- Steve


