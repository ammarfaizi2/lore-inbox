Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbRGBOYK>; Mon, 2 Jul 2001 10:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265302AbRGBOYA>; Mon, 2 Jul 2001 10:24:00 -0400
Received: from t2.redhat.com ([199.183.24.243]:7410 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265300AbRGBOX4>; Mon, 2 Jul 2001 10:23:56 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <d3bsn7gftr.fsf@lxplus015.cern.ch> 
In-Reply-To: <d3bsn7gftr.fsf@lxplus015.cern.ch>  <3652.993803483@warthog.cambridge.redhat.com> 
To: Jes Sorensen <jes@sunsite.dk>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 15:22:56 +0100
Message-ID: <3484.994083776@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jes@sunsite.dk said:
>  But it's going to cost for the ones who do not support this. 

You don't need to make it out-of-line for all cases - or indeed in any case
where it isn't out-of-line already. Some architectures may have only IO
calls out-of-line (many already do). Some may have MMIO calls out-of-line
too - some already do that too.

It would just be nice to have a standard way of doing it, and in particular
it would be nice to pass the struct resource into the out-of-line functions
in the case where they _are_ out of line, so that the Iyou/O functions don't
have to play evil tricks with the numbers they're given to work out which bus
the caller wanted to talk to.

#ifdef OUT_OF_LINE_MMIO
#define res_readb(res, adr) (res->access_ops->readb(res, adr)
#else
#define res_readb(res, adr) readb(adr)
#endif

etc.

--
dwmw2


