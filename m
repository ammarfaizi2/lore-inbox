Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbSLRWXV>; Wed, 18 Dec 2002 17:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbSLRWVh>; Wed, 18 Dec 2002 17:21:37 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:54756 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267460AbSLRWVU>;
	Wed, 18 Dec 2002 17:21:20 -0500
Date: Wed, 18 Dec 2002 22:28:35 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218222835.GA14801@bjl1.asuk.net>
References: <1040216143.23393.1427.camel@pc-16.office.scali.no> <3E00D716.1010503@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E00D716.1010503@transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Terje Eggestad wrote:
> > fd = open("/dev/vsyscall", );
> > _vsyscall = mmap(NULL, getpagesize(),  PROT_READ|PROT_EXEC, MAP_SHARED,
> > fd, 0);
> 
> Very ugly -- then the application has to do indirect calls.

No it doesn't.

The application, or library, would map the vsyscall page to an address
in its own data section.  This means that position-independent code
can do vsyscalls without any relocations, and hence without dirtying
its own caller pages.

In some ways this is better than the 0xfffe0000 address: _that_
requires position-independent code to do indirect calls to the
absolute address, or to dirty its caller pages.

That said, you always need the page at 0xfffe0000 mapped anyway, so
that sysexit can jump to a fixed address (which is fastest).

-- Jamie
