Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277700AbRKACcK>; Wed, 31 Oct 2001 21:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277702AbRKACcA>; Wed, 31 Oct 2001 21:32:00 -0500
Received: from oyster.morinfr.org ([62.4.22.234]:5248 "EHLO oyster.morinfr.org")
	by vger.kernel.org with ESMTP id <S277700AbRKACbw>;
	Wed, 31 Oct 2001 21:31:52 -0500
Date: Thu, 1 Nov 2001 03:32:21 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: Neil Spring <nspring@zarathustra.saavie.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP ECN bits and TCP_RESERVED_BITS macro
Message-ID: <20011101033221.A627@morinfr.org>
Mail-Followup-To: Neil Spring <nspring@zarathustra.saavie.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011031152717.A25584@morinfr.org> <20011031154305.A11081@cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011031154305.A11081@cs.washington.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans un message du 31 oct à 15:43, Neil Spring écrivait :
> The line in your patch:
> 
> > -#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH)|TCP_FLAG_ECE|TCP_FLAG_CWR)
> > +#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH))
> 
> is, I believe, a very bad idea.  This preprocessor constant
> is used so that exceptional ECN processing (to handle ECE
> or CWR) can be done on the slow path.  This change would
> almost certainly break Linux's ECN implementation.

Well it is not. I already had that discussion in private with someone
else. 
In previous versions (changed in a 14pre), there was two definitions for
TCP_HP_BITS. Now there is _just_ this one.

~(OLD_TCP_RESERVED_BITS)|TCP_FLAG_ECE_|TCP_FLAG_CWR == ~(NEW_TCP_RESERVED_BITS)

with
OLD_TCP_RESERVED_BITS = __constant_htonl(0x0FC00000),
NEW_TCP_RESERVED_BITS = __constant_htonl(0x0F000000),

So you see that I did _not_ change the value of TCP_HP_BITS. You surely
have noticed that change was not 'needed' since 
~(NEW_TCP_RESERVED_BITS) == (~(NEW_TCP_RESERVED_BITS)|TCP_FLAG_ECE|TCP_FLAG_CWR)

But it is _much_ cleaner that way (at least imho)

> I see no "2" patch to netfilter code.

As I've stated, this change fixes the unclean target. Furthermore, some
cosmetic changes must be done to the LOG targets. It is trivial and
should be posted to netfilter-devel. I will do it as soon as this patch
will be accepted. But if you want to see a preview of those, just drop
me a message.

Regards,

-- 
Guillaume Morin <guillaume@morinfr.org>

          5 years from now everyone will be running free GNU on their
           200 MIPS, 64M SPARCstation-5 (Andy Tanenbaum, 30 Jan 1992)
