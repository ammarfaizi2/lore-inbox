Return-Path: <linux-kernel-owner+w=401wt.eu-S1422760AbWLUGoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbWLUGoJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWLUGoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:44:09 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:29443 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422760AbWLUGoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:44:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=1hmEwaWVw9927SJqM2xo+zKHSlnlBtCgIT2CC4FV6k66euMEd25ly9GXNl+KAuPwQOL0Ln2A1YBF9ePF9mrrjag+6FQSzXwGkl3xvHrgZ2q0QsCoKl4vAlM1QHCOEKElqTumI5rdohb85zv6bUi6AEnFeSJaEAMHABlhR8YuEa0=  ;
X-YMail-OSG: FRu6gWEVM1kJgbq_4qdhxekGHi3dNI1.eQBWEOyKt_GsexMuFj_gRclUcu_1cXxeuH1pVdl2q2.vMEDfgpOlPvLmpJeFJJhLva9CLZxDmCg2HTBMrooRtXXuQuRdibO61BRd6DEbEaLon6c-
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Wed, 20 Dec 2006 22:44:02 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201312.36616.david-b@pacbell.net> <20061220221252.732f4e97.akpm@osdl.org>
In-Reply-To: <20061220221252.732f4e97.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202244.03351.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 10:12 pm, Andrew Morton wrote:
> On Wed, 20 Dec 2006 13:12:35 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > +/* REVISIT these macros are correct, but suffer code explosion
> > + * for non-constant parameters.  Provide out-line versions too.
> > + */
> > +#define gpio_get_value(gpio) \
> > +	(GPLR(gpio) & GPIO_bit(gpio))
> > +
> > +#define gpio_set_value(gpio,value) \
> > +	((value) ? (GPSR(gpio) = GPIO_bit(gpio)):(GPCR(gpio) = GPIO_bit(gpio)))
> 
> Why not implement them as inline functions?

I just collected and forwarded the code from Philip...
the better not to lose such stuff!  :)

 
> Or non-inline functions, come to that.

In this case I think that'd be preferable; see what those macros
expand to on pxa27x CPUs.


> Either way, programming in C is preferable to this ;)

Hey, at least we've started using these new fangled "function prototypes"!

I remember when we had to walk five miles through LINT every morning.
Uphill.  Then it was another five miles uphill on the way back, through
a maze of twisty octal contants like "8" and "9".  We didn't even have
void pointers.  UIDs were eight bits.  This ANSI stuff you new kids are
using ... you've got it easy!!

