Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTBGWZw>; Fri, 7 Feb 2003 17:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTBGWZw>; Fri, 7 Feb 2003 17:25:52 -0500
Received: from [81.2.122.30] ([81.2.122.30]:64778 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266755AbTBGWZv>;
	Fri, 7 Feb 2003 17:25:51 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302072235.h17MZduS003137@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
To: jamagallon@able.es (J.A. Magallon)
Date: Fri, 7 Feb 2003 22:35:39 +0000 (GMT)
Cc: root@chaos.analogic.com, rmk@arm.linux.org.uk, fdavis@si.rr.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030207215817.GA2092@werewolf.able.es> from "J.A. Magallon" at Feb 07, 2003 10:58:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    for (new2size = 128; new2size < newsize; new2size <<= 1)
> >        ;
> > 
> > The code seems to want to make the value of new2size a power of
> > 2 and, greater than 128, but less than newsize. It ignores the
> > fact that newsize might be less than 128, maybe this is okay.
> > But, the code goes on, eventually settling on new2size being
> > less than 4096... hmmm. I'll bet this could be greatly
> > simplified. I think 'new2size' is really something that will
> > fit inside 128-byte groups. Maybe an & or a % will greatly
> > simplify?
> > 
> 
> Isn't just a ffs or the like ?

I'm just wondering whether

if (newsize > 4096) newsize = 4096;

can be removed, because:

hwrate is verified to be between 3 and 255, so 10000/hwrate will be

39 < hwrate < 3333

and ignoring the lower two bits, (& ~3),

36 < hwrate < 3332

so:

for (new2size = 128; new2size < newsize; new2size <<= 1) ;

will never cause new2size to evaluate to more than 4096 anyway.

(as far as I can see).

John.
