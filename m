Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132579AbRDKOct>; Wed, 11 Apr 2001 10:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132595AbRDKOck>; Wed, 11 Apr 2001 10:32:40 -0400
Received: from mx0.gmx.net ([213.165.64.100]:17689 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S132589AbRDKOc1>;
	Wed, 11 Apr 2001 10:32:27 -0400
Date: Wed, 11 Apr 2001 16:32:25 +0200 (MEST)
From: Andreas Franck <afranck@gmx.de>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: dhowells@cambridge.redhat.com, torvalds@transmeta.com, andrewm@uow.edu.au,
        bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
In-Reply-To: <16795.986998639@warthog.cambridge.redhat.com>
Subject: Re: [PATCH] 2nd try: i386 rw_semaphores fix
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000112505@gmx.net
X-Authenticated-IP: [137.226.38.42]
Message-ID: <1098.986999545@www17.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David and people,

> I've just consulted with one of the gcc people we have here, and he says
> that
> the '"memory"' constraint should do the trick.
> 
> Do I take it that that is actually insufficient?

I don't remember exactly, it's been a while, but I think it was not
sufficient when I came up with this change. I can look at it in a few
hours.

The GCC manual is not really precise here:

> If your assembler instruction modifies memory in an unpredictable fashion,

> add `memory' to the list of clobbered registers. This will cause GNU CC to
> not keep memory values cached in registers across the assembler 
> instruction. You will also want to add the volatile keyword if the memory
> affected is not listed in the inputs or outputs of the
> asm, as the `memory' clobber does not count as a side-effect of the asm. 

So 'memory' alone won't probably do the trick, as caching is not the
problem here, but the unknown storage size of the semaphore. 

Perhaps the __voaltile__ will help, but I don't know. 

What are the reasons against mentioning sem->count directly as a "=m" 
reference? This makes the whole thing less fragile and no more dependent
on the memory layout of the structure.

Greetings,
Andreas

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

