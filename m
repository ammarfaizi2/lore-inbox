Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRBFJNV>; Tue, 6 Feb 2001 04:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129924AbRBFJNK>; Tue, 6 Feb 2001 04:13:10 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:64671 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129792AbRBFJNG>; Tue, 6 Feb 2001 04:13:06 -0500
To: Paul <set@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM question (ramfs abuse)
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
	<m3lmrqrspv.fsf@linux.local> <20010203234550.A507@squish>
	<m3zog2n6ec.fsf@linux.local> <20010205210540.A10316@squish>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20010205210540.A10316@squish>
Message-ID: <m3ofwgb4q7.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 06 Feb 2001 10:18:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, 5 Feb 2001, set@pobox.com wrote:
> Christoph Rohland <cr@sap.com>, on Sun Feb 04, 2001 [10:53:26 AM] said:
> @>Paul <set@pobox.com> writes:
> @>> I finally managed to coax the cursor over to mutt and quit it. Then things
> @>> were instantly fine and I could remove 'blob'.
> @>> 	My question is, why wasnt any swap used during this time? Ramfs
> @>> may not have any backing store?
> @>
> @>Because RAMFS lives in _physical_ ram. Grab my tmpfs patch and you
> @>will have ramfs + swapping and accounting. But set a limit (Mount
> @>option size) to it before doing anything like 
> @>'dd if=/dev/zero of=blob' ;-)
> @>
> 	Dear Christoph;
> 
> 	First, thankyou for the reply. Heh. Meant to send to the list,
> but got only you. Oh well.
> 	I have been testing tmpfs on 2.4.1. I havent encountered any
> problems, but I have a question. (with a limit, the pathological dd worked
> just fine :) For fun, I did a
> 'time (make dep && make clean && make bzImage)' using 2.2.18, 2.4.1, and
> various fs's as /tmp. (reiser, ext2, ramfs, tmpfs) Both using and not
> using the -pipe gcc option during the build.
> 	I was somewhat suprised that each time was the same (within, like
> 1/10th of a percent)

You probably have to stress some more since the page cache is _very_
effective on Linux. I can bring down a kernel compile on a 8way
machine with parallel make from ~44 seconds to ~40 seconds which is a
real speedup ;-)

Actually I really doubt a real speed benefit for normal users with
tmpfs but there may be other benefits:

- 'add swap on any device and your tmpfs grows' can be really valuable. 
- Automatic cleanup of /tmp on reboot
- No traces of temporary files on backing store may help the crypto
  people. (But no if you swap that argument is hosed.)
- ???

There are some people out there which really wanted to have this and
it was a minor task to add the full support to shm fs.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
