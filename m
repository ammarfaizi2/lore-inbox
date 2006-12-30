Return-Path: <linux-kernel-owner+w=401wt.eu-S1030220AbWL3Ci4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWL3Ci4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWL3Ci4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:38:56 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:48430 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030220AbWL3Ciz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:38:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=FWuadV5AQFeRvtnpmCAWaPalMgkkZfQDYtvUoGAm0ZgB60LlobQ5wwzdpExX/YSCx9kM4RJze6sWgzKlWtWGzKggL9a+4+O6av7mgSvDwhALsqw1UPSsTblBw6XmSpOzcpmL3dlJpFxRt7pSvb1Usfskj3aFf6mSW+gb1PNrZ/A=  ;
X-YMail-OSG: Fzn68dkVM1kYJ2iB3XdJF7ZZzKCeDdJeTOElzTNekbjhGQ_XSeZ8ip4xHNkZSkaPz8AtPu_K_G3NektIpL0XrXln0Op6df5H1WqAwBWkj1oyDkSuXRI7kJKAK3E2oGsFieze66XzQGqKof2EzoK3euUduHfodBCS30Q-
From: David Brownell <david-b@pacbell.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Fri, 29 Dec 2006 18:38:52 -0800
User-Agent: KMail/1.7.1
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200612281247.36869.david-b@pacbell.net> <Pine.LNX.4.64.0612292107580.18171@xanadu.home>
In-Reply-To: <Pine.LNX.4.64.0612292107580.18171@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612291838.53166.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 December 2006 6:15 pm, Nicolas Pitre wrote:
> On Thu, 28 Dec 2006, David Brownell wrote:
> 
> > Phillip:  is this the final version, then?  It's missing
> > a signed-off-by line, so I can't do anything appropriate.
> > 
> > Nico, your signoff here would be a Good Thing too if it
> > meets your technical review.  (My only comment, ISTR, was
> > that gpio_set_value macro should probably test for whether
> > the value is a constant too, not just the gpio pin.)
> 
> I don't think so.  Expansion of GPIO_bit(x) is pretty simple even if x 
> is not constant.  That probably makes it still less costly than a 
> function call.

I was more concerned with the "value" ... that expands to a conditional,
which is likely to cost a couple more instructions regardless, which in
space terms competes with a function call.

But I concluded much the same thing when I did that experimental
conversion ... not because I was comparing the space for conditional
vs funcall, but because the existing code already had the conditional.
If more code savings can be had later, so be it ... no rush for now.

- Dave

