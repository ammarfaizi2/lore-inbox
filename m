Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVA1SoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVA1SoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVA1Snn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:43:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43160 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262721AbVA1Smp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:42:45 -0500
Date: Fri, 28 Jan 2005 19:42:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050128184234.GA24226@elte.hu>
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com> <1106856178.5624.128.camel@laptopd505.fenrus.org> <41F94B5A.2030301@comcast.net> <41FA74CA.2030303@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA74CA.2030303@grupopie.com>
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


* Paulo Marques <pmarques@grupopie.com> wrote:

> I really shouldn't feed the trolls, but this must be the most silly
> piece of code I saw on this mailing list in a very long time (and
> there have been some good examples over time).

yeah.

> The stack randomization doesn't prevent some sort of attacks (like
> return into libc, etc.) and given a small randomization it might be
> possible to write an exploit with a long sequence of NOP's and a
> return address somewhere in there (the attacker wouldn't know exactly
> where, but it wouldn't matter anyway). If we are able to write 'N'
> NOP's then we get a 'N'/64k chance that the exploit works.

yeah. NOP techniques can always be used to 'chop off bits' from any
randomization, in case the address of the payload is not known. Both
instruction NOPs for shellcode and 'parameter NOPs' ("././././" strings
or "/bin/sh\0/bin/sh\0" strings) can be used.

but there is no fundamental theoretical difference between a 256 MB
randomization (as PaX uses) and a 2 MB randomization (Fedora) in terms
of characteristics: what is brute-force in one is brute-force in the
other as well, with a factor of overhead difference of 128. (which makes
the attack 128 times longer, but has no real difference to security.)

so the attempt of our beloved troll to paint 2 MB of randomization as
'weak' and 256 MB randomization as 'strong' is i believe misguided: both
are 'weak' in most of the threat models! (and even for threat types
where they might be considered 'strong' (e.g. whether a hole is suitable
to feed a destructive worm), they'll both be considered 'strong'.)

(obligatory note: the randomization we can get on 64-bit VMs is
different and probably completely adequate against all currently
existing remote threats, and maybe even against most of the practical
local threats.)

	Ingo
