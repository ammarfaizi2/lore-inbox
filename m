Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVCOL2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVCOL2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVCOL2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:28:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:52967 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261152AbVCOL2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:28:09 -0500
Date: Tue, 15 Mar 2005 12:27:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, andrea@cpushare.com,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315112712.GA3497@elte.hu>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315100903.GA32198@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> see my earlier counter-arguments in the thread starting at:
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=110630922022462&w=2
> 
> end result of the thread: seccomp is completely unnecessary code-bloat
> and can be equivalently implemented via ptrace. I cannot believe this
> made it into -BK ...

let me moderate my initial reaction somewhat:

the point i see in seccomp is that while it cannot be trusted right now
(not because of any known factor but simply because it doesnt have
enough review, yet), it might at a certain point (in many years) become
more trustable than TRACE_SYSCALLS.

It doesnt use a 'server' process to control syscall execution,
everything is enforced by the kernel. It is also intentionally simple,
and hence maybe even provably secure from a Comp-Sci POV. (assuming
sys_read()/sys_write() and hardware-irq processing itself is secure,
which quite likely wont be provable in the foreseeable future).

Also, while the technological arguments i raised in support of ptrace
are true, ptrace has a perception issue: it is perceived as insecure -
even if PTRACE_TRACE itself is not affected. And when building trust in
a processing platform, perception is just as important as raw security.

this combination of arguments i think tips the balance in favor of
seccomp, but still, i hate the fact that the anti-ptrace sentiment was
used as a vehicle to get this feature into the kernel.

technical comment: seccomp goes outside the audit/selinux framework,
which i believe is a bug. Andrea?

	Ingo
