Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVAKKce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVAKKce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVAKKcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:32:32 -0500
Received: from canuck.infradead.org ([205.233.218.70]:45580 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262664AbVAKKc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:32:29 -0500
Subject: Re: removing bcopy... because it's half broken
From: Arjan van de Ven <arjan@infradead.org>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
In-Reply-To: <20050111101010.GB27768@wavehammer.waldi.eu.org>
References: <20050109192305.GA7476@infradead.org>
	 <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
	 <20050109203459.GA28788@infradead.org>
	 <Pine.LNX.4.58.0501091240550.2339@ppc970.osdl.org>
	 <20050111101010.GB27768@wavehammer.waldi.eu.org>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 11:32:12 +0100
Message-Id: <1105439533.3917.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 11:10 +0100, Bastian Blank wrote:
> On Sun, Jan 09, 2005 at 12:42:42PM -0800, Linus Torvalds wrote:
> > On Sun, 9 Jan 2005, Christoph Hellwig wrote:
> > > We're building with -ffreestanding now, so gcc isn't allowed to emit
> > > any calls to standard library functions.
> > Bzzt. It still emits calls to libgcc. 
> 
> Yes. This means IMHO that the image and every module needs to link
> against libgcc to include the required symbols. It is rather annoying to
> see modules asking for libgcc symbols.

I disagree with your first sentence: The kernel provides the required
symbols (bcopy is special here, it no longer gets emitted by gcc since
like gcc version 2.6); the ones the kernel does NOT provide are
generally undesirable in kernel spec, eg floating point and 64 bit
divisions...


