Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbSLTKBr>; Fri, 20 Dec 2002 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267787AbSLTKBr>; Fri, 20 Dec 2002 05:01:47 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:21965
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267786AbSLTKBq>; Fri, 20 Dec 2002 05:01:46 -0500
Message-ID: <3E02EC30.8030407@redhat.com>
Date: Fri, 20 Dec 2002 02:08:48 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: bart@etpmod.phys.tue.nl, davej@codemonkey.org.uk,
       lk@tantalophile.demon.co.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, matti.aarnio@zmailer.org, hugh@veritas.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212191134180.2731-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212191134180.2731-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> For _zero_ gain.  The jump to the library address has to be indirect 
> anyway, and glibc has several places to put the information without any 
> mmap's or anything like that.

Correct.  The current implementation is optimal.

It is necessary to have indirection since the target address can change.

I'm never going to use self-modifying code.

And it's a simple, one-instruction change.

  int $0x80  ->  call *%gs:0x18


That's it.  It's all implemented and tested.  The results are in the
latest NPTL source drop.  The code won't be available in LinuxThreads
since it requires a kernel with TLS support.

As far as I'm concerned the discussion is over.  I'm happy with what I
have now.  The additional overhead for the case when AT_SYSINFO is not
available is neglegable (and can be compiled-out completely if one
really wants), and in case AT_SYSINFO is available the code really is
the fatest possible given the constraints mentioned above.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

