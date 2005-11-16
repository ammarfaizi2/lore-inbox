Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVKPKlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVKPKlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVKPKlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:41:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64136 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932599AbVKPKlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:41:02 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: "Wed, 16 Nov 2005 11:18:12 +0100" <grundig@teleline.es>
Cc: alex14641@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116111812.4a1ea18a.grundig@teleline.es>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
	 <1132128212.2834.17.camel@laptopd505.fenrus.org>
	 <20051116111812.4a1ea18a.grundig@teleline.es>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Nov 2005 11:40:37 +0100
Message-Id: <1132137638.2834.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.5 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.7 ADDR_NUMS_AT_BIGSITE   Uses an address with lots of numbers, at a big ISP
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 11:18 +0100, Wed, 16 Nov 2005 11:18:12 +0100
wrote:
> El Wed, 16 Nov 2005 09:03:32 +0100,
> Arjan van de Ven <arjan@infradead.org> escribió:
> 
> 
> > * more stack space is available for interrupts compared to 2.4 kernels
> >    - in 2.4 kernels only 2Kb was available for interrupt context (to
> >      keep 4K available for user context). With complex softirqs such as
> >      PPP and firewall rules and nested interrupts this wasn't always
> >      enough. Compared to 2.6-with-8Kstacks is a bit harder; there is
> >      2Kb extra available there compared to 2.4 and arguably some of that
> >      extra is for interrupts.
> 
> 
> I would like to contribute that listing with two non-technical reasons
> more:
> 
>  * Encourages good code. Due to the 4 Kb stacks patch several parts of
> 	the kernel have gone on diet, improving the quality of the code

this argument I agree with. especially since 64 bit platforms have a
higher stack footprint by nature (bigger call frames and more to store
on the stack) and if x86 allows stackbloat, the other architectures get
in trouble and are going to need really large stacks.

>  * Some distros are enabling 4KB (fedora), other distros aren't, so
> 	having a single stack size option will make 3rd party modules
> 	distribution easier (some propietary drivers may not be caring
> 	about making their drivers work with 4Kb stacks due to the lack
> 	of uniformity)

this I don't see as a reason; illegal drivers should never be a reason
to clutter our kernel one way or the other. And for GPL 3rd party
drivers the problem isn't there realistically. If they were reliable in
2.4, they're reliable with 2.6+4K stacks. If they're not then they need
to be fixed (eg your previous point).

