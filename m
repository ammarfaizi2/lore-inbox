Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRCMXjb>; Tue, 13 Mar 2001 18:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRCMXjW>; Tue, 13 Mar 2001 18:39:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9147 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131323AbRCMXjO>;
	Tue, 13 Mar 2001 18:39:14 -0500
Message-ID: <3AAEAF58.3F4BDA3B@mandrakesoft.com>
Date: Tue, 13 Mar 2001 18:38:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac20
In-Reply-To: <E14cgXm-0003O5-00@the-village.bc.nu> <20010313161704.A15082@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:
> 
> On Tue, Mar 13, 2001 at 04:36:18AM +0000, Alan Cox wrote:
> ...
> >
> > 2.4.2-ac20
> ...
> > o     Fix Alpha build                                 (Jeff Garzik)
> 
> Now I see (at least on Alpha) a constant wailing:
> 
> ..../linux-2.4.2ac/include/linux/binfmts.h:45: warning: `struct
> mm_struct' declared inside parameter list
> ..../linux-2.4.2ac/include/linux/binfmts.h:45: warning: its scope is
> only this definition or declaration, which is probably not what you want
> 
> Is this somehow related?

Nope, I saw that before the patch.  My patch was, in any case, to a
single .c file, not a header file, so it wouldn't spew like that.

It compiled and booted, I moved on :)

So solve that warning you probably need to shuffle the delicate balance
of includes around so that linux/sched.h, where mm_struct is defined, is
included before binfmts.h.  Or have binfmt.h include sched.h (which
should work... but its all kinds of nested nastiness)

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
