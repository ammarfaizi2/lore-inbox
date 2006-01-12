Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWANJdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWANJdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWANJdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:33:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20487 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751546AbWANJdx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:33:53 -0500
Date: Thu, 12 Jan 2006 01:04:06 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@davemloft.net>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
Message-ID: <20060112010406.GA2367@ucw.cz>
References: <43C42F0C.10008@redhat.com> <20060111.000020.25886635.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111.000020.25886635.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 11-01-06 00:00:20, David S. Miller wrote:
> From: Ulrich Drepper <drepper@redhat.com>
> Date: Tue, 10 Jan 2006 14:02:52 -0800
> 
> > I just saw this in a patch:
> > 
> > +               if (ntohs(ih->frag_off) & IP_OFFSET)
> > +                       return EBT_NOMATCH;
> > 
> > This isn't optimal, it requires a byte switch little endian machines.
> > The compiler isn't smart enough.  It would be better to use
> > 
> >      if (ih->frag_off & ntohs(IP_OFFSET))
> > 
> > where the byte-swap can be done at compile time.  This is kind of ugly,
> > I guess, so maybe a dedicate macro
> > 
> >     net_host_bit_p(ih->frag_off, IP_OFFSET)
> 
> The first suggestion isn't considered ugly, and the best form is:
> 
> 	if (ih->frag_off & __constant_htons(IP_OFFSET))
> 
> I'll fix that up when I get a chance, thanks for catching it Uli.

Could you possibly 
#define IP_OFFSET htons(1234)
?

Noone should need it in native endianity, no?

-- 
Thanks, Sharp!
