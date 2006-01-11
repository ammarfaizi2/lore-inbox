Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWAKINX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWAKINX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAKINX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:13:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33260 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751087AbWAKINW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:13:22 -0500
Subject: Re: ntohs/ntohl and bitops
From: Arjan van de Ven <arjan@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060111.000020.25886635.davem@davemloft.net>
References: <43C42F0C.10008@redhat.com>
	 <20060111.000020.25886635.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 09:13:11 +0100
Message-Id: <1136967192.2929.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 00:00 -0800, David S. Miller wrote:
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

why this __constant_htons and not just plain htons ??
htons() gets auto-remapped to that anyway via the builtin "is this a
constant" thing...... and to be honest htons() is more readable.


