Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbULAILa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbULAILa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbULAILa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:11:30 -0500
Received: from canuck.infradead.org ([205.233.218.70]:8196 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261333AbULAILN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:11:13 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       dhowells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       hch@infradead.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411301612370.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <8219.1101828816@redhat.com>
	 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
	 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
	 <1101854061.4574.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
	 <1101858657.4574.33.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411301612370.22796@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1101888653.2640.10.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 01 Dec 2004 09:10:53 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Tue, 2004-11-30 at 16:18 -0800, Linus Torvalds wrote:
> On Tue, 30 Nov 2004, Linus Torvalds wrote:
> > 
> > Even atomic.h. I could well imagine that somebody includes atomic.h just 
> > to get the thread-safe updates for some architectures. For example, 
> > asm-alpha/atomic.h does it right, and I would not be at all surprised if 
> > somebody had noticed.
> 
> In fact, this is not entirely theoretical.

indeed it's not. THere were projects that used the x86 atomic.h
header.... but failed to notice that its not actually using the lock
prefix if you don't define CONFIG_SMP. Now it's purely up to luck if the
userspace headers in /usr/include have CONFIG_SMP defined or not, so
there have been cases where people compiled on an UP box and got racy
code. Was a production level project; normally they built on SMP but
once they built on UP .. poof ;)

so atomic.h is *dangerous* for userspace to use, at least on x86. It
gives a false feeling of atomicity.

So dangerous that for the RH/Fedora distros, we don't ship the
questionable parts of it.


