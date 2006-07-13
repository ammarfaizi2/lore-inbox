Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWGMEkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWGMEkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGMEkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:40:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:1939 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932496AbWGMEkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:40:21 -0400
Date: Thu, 13 Jul 2006 06:40:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713044053.GE9102@opteron.random>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de> <20060713030402.GC9102@opteron.random> <Pine.LNX.4.64.0607122010060.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607122010060.5623@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 08:12:16PM -0700, Linus Torvalds wrote:
> ALSA is used for other things _too_.

But there may be some users only using alsa to play mp3, so it's not
so different (certainly I agree if it would be nice if there would be
more users since it can solve the codec decompression exploits).

> I don't think SECCOMP is wrong per se, but I do believe that if other 
> approaches become more popular, and the only user of SECCOMP is not GPL'd 
> and uses some patented stuff, then we should seriously look at the other 
> interfaces (eg the extended ptrace).

You want to extend ptrace so I can run two ptraces of the same ptraced
task? (one to stop the syscalls from happening like current seccomp
does, the other to debug the task with gdb while it's under the first
ptrace?) I think Linux will be better off without this complication
(and I'll be better off too, I've enough paralleism to deal with
already in this project without this one more ;)

If what you don't like is the API and you want to change it (like
replacing the /proc interface with a syscall or a prctl) that's fine
with me though.

> Does anybody actually really _use_ SECCOMP outside of the patented
> stuff?

Just a side note, it's patent-pending, not patented. It may never be
patented infact, all these discussion sounds very premature to me.

About your question, does it really matter what I would answer, given
we already have code in the kernel that can only be used in
combination with patented software and that it isn't useful for
anything else?

config X86_LONGRUN
        tristate "Transmeta LongRun"
        help
          This adds the CPUFreq driver for Transmeta Crusoe and Efficeon processors
          which support LongRun.

          For details, take a look at <file:Documentation/cpu-freq/>.

          If in doubt, say N.

Both these files:

     linux-2.6/arch/i386/kernel/cpu/cpufreq/longrun.c
     linux-2.6/arch/i386/kernel/cpu/transmeta.c

are only useful if used in comination with the CMS patented software
(Combining hardware and software to provide an improved
microprocessor):

     http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=%2Fnetahtml%2FPTO%2Fsearch-bool.html&r=50&f=G&l=50&co1=AND&d=PTXT&s1=transmeta.ASNM.&OS=AN/transmeta&RS=AN/transmeta

Furthermore the transmeta.o generates a 2964 bytes object, and cannot
be set to N, so it's linked in all i386 kernels out there, seccomp.o
OTOH can be set to N generating zero bytes of overhead and its final
.o size is 1108 bytes.

If you are aware of any other use of the above two files other than
the patented stuff you probably may want to communicate it to
Transmeta cause I guess they would be interested to know.
