Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291778AbSBHUE7>; Fri, 8 Feb 2002 15:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291779AbSBHUEt>; Fri, 8 Feb 2002 15:04:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:522 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291778AbSBHUEg>;
	Fri, 8 Feb 2002 15:04:36 -0500
Message-ID: <3C642F52.ABD14619@mandrakesoft.com>
Date: Fri, 08 Feb 2002 15:04:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, Alexander Viro <viro@math.psu.edu>,
        Andrew Morton <akpm@zip.com.au>, Martin Wirth <Martin.Wirth@dlr.de>,
        Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        haveblue <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.LNX.4.33.0202081328060.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Feb 2002, Ingo Molnar wrote:
> >
> > and regarding the reintroduction of BKL, *please* do not just use a global
> > locks around such pieces of code, lock bouncing sucks on SMP, even if
> > there is no overhead.
> 
> I'd suggest not having a lock at all, but instead add two functions: one
> to read a 64-bit value atomically, the other to write it atomically (and
> they'd be atomic only wrt each other, no memory barriers etc implied).
> 
> On 64-bit architectures that's just a direct dereference, and even on x86
> it's just a "cmpxchg8b".

Are there architectures out there that absolutely must implement this
with a spinlock?  Your suggested API of functions to read/write 64-bit
values atomically would work for such a case, but still I am just
curious.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
