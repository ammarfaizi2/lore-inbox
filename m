Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVEMTaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVEMTaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVEMTZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:25:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262503AbVEMTXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:23:39 -0400
Date: Fri, 13 May 2005 15:23:28 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050513192328.GB24166@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050513184806.GA24166@redhat.com> <1116011692.6694.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116011692.6694.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:14:52PM +0200, Arjan van de Ven wrote:
 > On Fri, 2005-05-13 at 14:48 -0400, Dave Jones wrote:
 > >  	if (up->port.flags & UPF_CONS_FLOW) {
 > >  		tmout = 1000000;
 > >  		while (--tmout &&
 > > -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
 > > +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
 > >  			udelay(1);
 > > +			touch_nmi_watchdog();
 > > +		}
 > >  	}
 > >  }
 > >  
 > > 
 > > We *could* tickle it less often, but given we're busy waiting anyway
 > > it probably doesnt make sense to not favour the more simple approach.
 > > Hmm, maybe we want a cpu_relax() in there too. opinions?
 > 
 > udelay() includes cpu_relax() already so that is futile.
 > 
 > However.. this is a hack. Do we really need to do busy waiting here for
 > this long??

Ohhhhh no. I've fallen into this trap before.
I'm not looking any further into serial code than I have to :)

Russell / dwmw2 may have a more definitive answers as to why
we have such a long wait here, but every time I learn something
about the serial layer I end up regretting it, so mine is a
drive-by patching only :-)

		Dave

