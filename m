Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbRGPTZi>; Mon, 16 Jul 2001 15:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbRGPTZ2>; Mon, 16 Jul 2001 15:25:28 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:39686 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S267678AbRGPTZL>;
	Mon, 16 Jul 2001 15:25:11 -0400
Message-ID: <938F7F15145BD311AECE00508B7152DB034C48DD@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'Andreas Jaeger'" <aj@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: /proc/sys/kernel/hz
Date: Mon, 16 Jul 2001 21:24:26 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right.

The macro CLOCKS_PER_SEC is used for AT_CLKTCK, and for some architectures
there actually _is_ a relationship between CLOCKS_PER_SEC and HZ, and for
some there is _not_ (linux/include/asm-*/param.h).

For i386 the relation apparently _is_ there. For IA64 there's the assumption
however that that the relation is _not_ there, the kernel assumes that it's
100 HZ for ia32 _always_. Weird.

Still leaves me wondering about procps.

Thanks,

Rolf

-----Original Message-----
From: Andreas Jaeger [mailto:aj@suse.de]
Sent: Monday, July 16, 2001 8:34 PM
To: Rolf Fokkens
Cc: 'drepper@cygnus.com'; 'alan@lxorguk.ukuu.org.uk';
'linux-kernel@vger.kernel.org'
Subject: Re: PATCH: /proc/sys/kernel/hz


Rolf Fokkens <FokkensR@vertis.nl> writes:

> Ulrich Drepper <drepper@redhat.com> writes:
> 
>>> Some software (like procps) needs the HZ constant in the kernel. It's
>>> sometimes determined by counting jiffies during a second. The attached
> patch
>>> just "publishes" the HZ constant in /proc/sys/kernel/hz.
>>
>>And what is wrong with
>>  getconf CLK_TCK
>>or programmatically
>>  hz = sysconf (_SC_CLK_TCK);
> 
> In short: it doesn't work: it reads 100 while I changed it to 1024 in my
> kernel.

Then your kernel is broken, check AT_CLKTCK,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
