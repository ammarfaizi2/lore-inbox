Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbSLRWbZ>; Wed, 18 Dec 2002 17:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbSLRWbZ>; Wed, 18 Dec 2002 17:31:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51977 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267367AbSLRWbW>; Wed, 18 Dec 2002 17:31:22 -0500
Message-ID: <3E00F91E.80200@transmeta.com>
Date: Wed, 18 Dec 2002 14:39:26 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Terje Eggestad <terje.eggestad@scali.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <1040216143.23393.1427.camel@pc-16.office.scali.no> <3E00D716.1010503@transmeta.com> <20021218222835.GA14801@bjl1.asuk.net>
In-Reply-To: <20021218222835.GA14801@bjl1.asuk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> H. Peter Anvin wrote:
> 
>>Terje Eggestad wrote:
>>
>>>fd = open("/dev/vsyscall", );
>>>_vsyscall = mmap(NULL, getpagesize(),  PROT_READ|PROT_EXEC, MAP_SHARED,
>>>fd, 0);
>>
>>Very ugly -- then the application has to do indirect calls.
> 
> 
> No it doesn't.
> 
> The application, or library, would map the vsyscall page to an address
> in its own data section.  This means that position-independent code
> can do vsyscalls without any relocations, and hence without dirtying
> its own caller pages.
> 

Oh, I see... you don't really mean NULL in the first argument :)

This has one additional advantage: an application which wants to
override vsyscalls can simply map something instead of the kernel page,
and UML can present its own vsyscall page.

> In some ways this is better than the 0xfffe0000 address: _that_
> requires position-independent code to do indirect calls to the
> absolute address, or to dirty its caller pages.
> 
> That said, you always need the page at 0xfffe0000 mapped anyway, so
> that sysexit can jump to a fixed address (which is fastest).

That's a possiblity, or if the task_struct contains the desired return
address for a particular process that might also work -- it's just a GPR
after all.

	-hpa



