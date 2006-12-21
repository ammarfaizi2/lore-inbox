Return-Path: <linux-kernel-owner+w=401wt.eu-S1423049AbWLUTZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423049AbWLUTZx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423054AbWLUTZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:25:53 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:31495 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1423049AbWLUTZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:25:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=wMXIa/fd/sWhaPkwMrjpQJuXMxSEFs3Ya2Qb6jAYt8FEXHqNqMAFlVcoeQGc7RhkAzbUjZxGL0kXSQB/7twC+NoB69bcX9E1ytX8z8sN/79ewe1J/sGBBSK1i/pCPEMfg6F9MFIlAb7H2J4pbLl8cGXYy4S4soyes1Jc7PJjTA0=  ;
X-YMail-OSG: 8bDpq3oVM1ms7Q3SGXFCg8PEInrJLoVbMr0GvUQAxVB1.TVn6sB7E2g8bJGYKzsRefYOiTl8KpA5xRBeerEwKrW0hfsdGNPFWU4w3IWdPs0Ftx1pzhXqdwyAJDLw8B86Z_4MNgiR1td85JdtUZ4HOZHHrFKnYy1VRpx1ZwU6Y0Ecgd4auPJ9FVz1DHVH
From: David Brownell <david-b@pacbell.net>
To: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Thu, 21 Dec 2006 11:25:47 -0800
User-Agent: KMail/1.7.1
Cc: "Nicolas Pitre" <nico@cam.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <Pine.LNX.4.64.0612210925130.18171@xanadu.home> <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com>
In-Reply-To: <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612211125.49226.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 December 2006 7:03 am, pHilipp Zabel wrote:
> On 12/21/06, Nicolas Pitre <nico@cam.org> wrote:

> +static inline void __gpio_set_value(unsigned gpio, int value)
> +{
> +	if (value)
> +		GPSR(gpio) = GPIO_bit(gpio);
> +	else
> +		GPCR(gpio) = GPIO_bit(gpio);
> +}
> +
> +#define gpio_set_value(gpio,value)		\
> +	(__builtin_constant_p(gpio) ?		\

Should that be testing for _both_ gpio and value being constant?
I tend to think it should (assuming nonconstant 'variable' means
this costs more than a function call) ...

> +	 __gpio_set_value(gpio, value) :	\
> +	 pxa_gpio_set_value(gpio, value))
