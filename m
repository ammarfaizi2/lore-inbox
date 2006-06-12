Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWFLLXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWFLLXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWFLLXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:23:09 -0400
Received: from canuck.infradead.org ([205.233.218.70]:18330 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751874AbWFLLXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:23:08 -0400
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060612083239.GA27502@mea-ext.zmailer.org>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	 <20060611072223.GA16150@flint.arm.linux.org.uk>
	 <20060612083239.GA27502@mea-ext.zmailer.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 12:22:55 +0100
Message-Id: <1150111375.8184.47.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 11:32 +0300, Matti Aarnio wrote:
> SPF is application level version of this type of source sanity
> enforcement, and all that I intend to do is to publish that TXT
> entry for VGER.  

Precisely _because_ SPF is at the application level, it doesn't make
sense. In the real world, you just can't assume that mail will arrived
_directly_ from the machine which originated it.

Think about what happens if you do your 'source IP sanity enforcement'
at the wrong level... if you insist that the MAC address on the Ethernet
packet you receive must match a MAC address published in DNS for that
host. If you do that, you _will_ break things because the Internet isn't
a single big Ethernet switch -- stuff gets _routed_. The same principle
applies to mail, and that's the problem with SPF.

You can make restrictions about which hosts may use your domain in HELO
(http://mipassoc.org/csv/), but linking domain names used in MAIL FROM:
to certain IP addresses is not compatible with current practice.

But let's back up a moment... precisely what is it that you think you
gain by publishing an SPF record for vger? There are almost certainly
better ways to achieve that goal, whatever it is.

You can address forgery _without_ having to break SMTP. I'd much rather
see vger doing DomainKeys/IIM and BATV.

I accept that you need to break eggs to make an omelette. But you don't
have to run amok in the kitchen, and smash the frying pan too.

-- 
dwmw2

