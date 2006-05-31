Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWEaSaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWEaSaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWEaSaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:30:00 -0400
Received: from gw.openss7.com ([142.179.199.224]:61319 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S965083AbWEaS35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:29:57 -0400
Date: Wed, 31 May 2006 12:29:55 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531122955.B10147@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060530235525.A30563@openss7.org> <20060531.001027.60486156.davem@davemloft.net> <20060531014540.A1319@openss7.org> <20060531.004953.91760903.davem@davemloft.net> <20060531020009.A1868@openss7.org> <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531110459.GA20551@2ka.mipt.ru> <20060531130615.GA32362@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060531130615.GA32362@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Wed, May 31, 2006 at 05:06:15PM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Wed, 31 May 2006, Evgeniy Polyakov wrote:
> > > >   Worse: he folded the jenkins algorith result with
> > > > 
> > > >    h ^= h >> 16;
> > > >    h ^= h >> 8;
> > > > 
> > > >   Destroying the coverage of the function.
> > > 
> > > It was done to simulate socket code which uses the same folding.
> > > Leaving 32bit space is just wrong, consider hash table size with that
> > > index.
> 
> Btw, that probably requires some clarification.
> Since hash table size is definitely less than returned hash value, so
> higher bits are removed, for that case above folding is done both in
> XOR hash and my test case. 
> It is possible to just remove higher bits, but fairly ditributed parts
> being xored produce still fairly distributed value.

> > > >    h ^= h >> 16;
> > > >    h ^= h >> 8;

This does not remove high order bits in either function.
Your comparison results are simply invalid with these two lines in place.

--brian
