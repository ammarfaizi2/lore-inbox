Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271780AbRHUS2U>; Tue, 21 Aug 2001 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271782AbRHUS2K>; Tue, 21 Aug 2001 14:28:10 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:48134 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271780AbRHUS16>;
	Tue, 21 Aug 2001 14:27:58 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 21 Aug 2001 18:24:44 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu91c$n5v$3@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.30.0108210957060.13373-100000@waste.org> <2348622871.998419449@[10.132.112.53]>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998418284 23743 128.32.45.153 (21 Aug 2001 18:24:44 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:24:44 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel  wrote:
>If we assume SHA-1 was
>not breakable, then /dev/urandom in a ZERO ENTROPY environment would
>give the the same value on a reboot of your machine as a simultaneous
>reboot of a hacker's machine. /dev/random would block (indefinitely)
>under these conditions. So /dev/urandom and /dev/random are
>both dysfunctional in this circumstance (one spits out a predictable
>number, one blocks), but differently dysfunctional, and
>/dev/random's behaviour is better.

Yup.  Fortunately, the countermeasure is simple: Your init script
should contain something like
  dd count=16 ibs=1 if=/dev/random of=/dev/urandom
This fixes the problem.  So this is arguably a user-level issue, not
a kernel issue.

>Similarly, if entropy disappears later on, then using /dev/urandom
>eventually  provides you with information about the state of the pool,
>though as the pool is SHA-1 hashed, it's a difficult attack to exploit.

No, it's not just difficult, it is completely infeasible under
current knowledge.

>So let's use Occam's razor and assume the attacker could have an SHA-1
>exploit,

No, let's not.  If the attacker has a SHA-1 exploit, then all your
SSL and IPSEC and other implementations are insecure, and they are
probably the only reason you're using /dev/random anyway.

Instead, let's assume SHA-1 is good, since it probably is, and since
you have to assume this anyway for the rest of your system.
