Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSLMVuY>; Fri, 13 Dec 2002 16:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSLMVuY>; Fri, 13 Dec 2002 16:50:24 -0500
Received: from jtkxgl.cm.chello.no ([62.179.175.88]:26260 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265484AbSLMVuX>; Fri, 13 Dec 2002 16:50:23 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Terje Eggestad <terje.eggestad@scali.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: "J.A. Magallon" <jamagallon@able.es>, Mark Mielke <mark@mark.mielke.cc>,
       "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <20021213155859.GC1095@niksula.cs.hut.fi>
References: <1039610907.25187.190.camel@pc-16.office.scali.no>
	<3DF78911.5090107@zytor.com>
	<1039686176.25186.195.camel@pc-16.office.scali.no>
	<20021212203646.GA14228@mark.mielke.cc>
	<20021212205655.GA1658@werewolf.able.es>
	<1039771270.29298.41.camel@pc-16.office.scali.no> 
	<20021213155859.GC1095@niksula.cs.hut.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 22:57:55 +0100
Message-Id: <1039816682.10496.13.camel@eggis1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tried the vsyscall patch, but there was a sysenter patch
floating around that I tried. It reduced the syscall overhead with 1/3
to 1/4, but I never tried it on P4.

FYI: Just note that I say overhead, which I assume to be the time it
take to do someting like getpid(), write(-1,...), select(-1, ...) (etc
that is immediatlely returned with -EINVAL by the kernel). 
Since the kernel do execute a quite afew instructions beside the
int/iret sysenter/sysexit, it's an assumption that the int 80  is the
culprit. 

I would be nice if someone bothered to try this on an windoze box.
(Un)fortunatly I live in a windoze free environment. :-)

TJ


On Fri, 2002-12-13 at 16:58, Ville Herva wrote:
    On Fri, Dec 13, 2002 at 10:21:11AM +0100, you [Terje Eggestad] wrote:
    >   
    > Well, it does make sense if Intel optimized away rdtsc for more commonly
    > used things, but even that don't seem to be the case. I'm measuring the
    > overhead of doing a syscall on Linux (int 80) to be ~280 cycles on PIII,
    > and Athlon, while it's 1600 cycles on P4.
    
    Just out of interest, how much would sysenter (or syscall on amd) cost,
    then? (Supposing it can be feasibly implemented.)
    
    I think I heard WinXP (W2k too?) is using sysenter?
    
    
    -- v --
    
v@iki.fi
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

