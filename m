Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314609AbSEPTkL>; Thu, 16 May 2002 15:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEPTkK>; Thu, 16 May 2002 15:40:10 -0400
Received: from holomorphy.com ([66.224.33.161]:64423 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314609AbSEPTkJ>;
	Thu, 16 May 2002 15:40:09 -0400
Date: Thu, 16 May 2002 12:38:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Todd R. Eigenschink" <todd@tekinteractive.com>
Cc: Mike Galbraith <EFAULT@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
Message-ID: <20020516193834.GI27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Todd R. Eigenschink" <todd@tekinteractive.com>,
	Mike Galbraith <EFAULT@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200205160528.g4G5S631019167@sol.mixi.net> <15587.42492.25950.446607@rtfm.ofc.tekinteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 07:28:44AM -0500, Todd R. Eigenschink wrote:
> Ooh, spiffy idea.  (Like I said, asm rookie.)  I just compiled gdb,
> and here's what it says.  Interesting, to me, at least.
> (gdb) list *__wake_up+0xb2
> 0x9d6 is in __wake_up
> (/src/linux-2.4.19-pre8/include/asm/processor.h:488).
> 483     #ifdef  CONFIG_MPENTIUMIII
> 484
> 485     #define ARCH_HAS_PREFETCH
> 486     extern inline void prefetch(const void *x)
> 487     {
> 488             __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
> 489     }
> 490
> 491     #elif CONFIG_X86_USE_3DNOW

list_for_each() uses prefetch() and is used in __wake_up_common(), which
is in turn used by __wake_up(). This is waitqueue list corruption.


Cheers,
Bill
