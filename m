Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291305AbSBMCHc>; Tue, 12 Feb 2002 21:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291307AbSBMCHZ>; Tue, 12 Feb 2002 21:07:25 -0500
Received: from suntan.tandem.com ([192.216.221.8]:962 "EHLO suntan.tandem.com")
	by vger.kernel.org with ESMTP id <S291305AbSBMCHO>;
	Tue, 12 Feb 2002 21:07:14 -0500
Message-ID: <3C69C59F.F86BF8F9@compaq.com>
Date: Tue, 12 Feb 2002 17:47:11 -0800
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, hch@caldera.de
Subject: Re: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
In-Reply-To: <E16amMb-0003RQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > +     new = old + RWSEM_ACTIVE_READ_BIAS;
> > +     if (cmpxchg(&sem->count, old, new) == old)
> > +             return 1;
> 
> cmpxchg isnt present on i386


According to arch/i386/config.in, the generic spinlock version would be
used for vintage 386 chips. I think that's due to similar concerns about
the xadd instruction.

-- 
Brian Watson                | "Now I don't know, but I been told it's
Linux Kernel Developer      |  hard to run with the weight of gold,
Open SSI Clustering Project |  Other hand I heard it said, it's
Compaq Computer Corp        |  just as hard with the weight of lead."
Los Angeles, CA             |     -Robert Hunter, 1970

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
