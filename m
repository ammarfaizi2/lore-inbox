Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264987AbSJWNbZ>; Wed, 23 Oct 2002 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbSJWNbZ>; Wed, 23 Oct 2002 09:31:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40453 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264987AbSJWNbY>;
	Wed, 23 Oct 2002 09:31:24 -0400
Date: Wed, 23 Oct 2002 14:37:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com
Subject: Re: [PATCH] use 1ULL instead of 1UL in kernel/signal.c
Message-ID: <20021023143734.N27461@parcelfarce.linux.theplanet.co.uk>
References: <20021022222719.H27461@parcelfarce.linux.theplanet.co.uk> <1035323879.329.185.camel@irongate.swansea.linux.org.uk> <20021022224853.I27461@parcelfarce.linux.theplanet.co.uk> <1035328632.329.187.camel@irongate.swansea.linux.org.uk> <20021023141712.M27461@parcelfarce.linux.theplanet.co.uk> <1035380911.3968.56.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035380911.3968.56.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Oct 23, 2002 at 02:48:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 02:48:31PM +0100, Alan Cox wrote:
> On Wed, 2002-10-23 at 14:17, Matthew Wilcox wrote:
> > +#if SIGRTMIN > 32
> > +#define M(sig) (1ULL << (sig))
> > +#else
> >  #define M(sig) (1UL << (sig))
> > +#endif
> 
> Not >= ??

No, definitely not >=.  Realtime signals are tested for separately, and
SIGRTMIN is the number of the lowest RT signal, not the number of the
highest non-realtime signal.  Take a look in include/asm-i386/signal.h:

#define SIGSYS          31
#define SIGUNUSED       31

/* These should not be considered constants from userland.  */
#define SIGRTMIN        32
#define SIGRTMAX        (_NSIG-1)

-- 
Revolutions do not require corporate support.
