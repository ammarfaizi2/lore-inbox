Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTAJOUd>; Fri, 10 Jan 2003 09:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTAJOUd>; Fri, 10 Jan 2003 09:20:33 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:65175 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S265190AbTAJOUS> convert rfc822-to-8bit; Fri, 10 Jan 2003 09:20:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: small migration thread fix
Date: Fri, 10 Jan 2003 15:29:33 +0100
User-Agent: KMail/1.4.3
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
References: <200301101346.03653.efocht@ess.nec.de> <20030110131100.GS23814@holomorphy.com>
In-Reply-To: <20030110131100.GS23814@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301101529.33302.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 January 2003 14:11, William Lee Irwin III wrote:
> I'm not mingo, but I can say this looks sane. My only question is
> whether there are more codepaths that need this kind of check, for
> instance, what happens if someone does set_cpus_allowed() to a cpumask
> with !(task->cpumask & cpu_online_map) ?

The piece of code below was intended for that. I agree with Rusty's
comment, BUG() is too strong for that case. 

#if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
	new_mask &= cpu_online_map;
	if (!new_mask)
		BUG();
#endif

Anyhow, changing the new_mask in this way is BAD, because the masks
are inherited. So when more CPUs come online, they remain excluded
from the mask of the process and it's children.

The fix suggested in the comments still has to be done...

Regards,
Erich

