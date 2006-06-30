Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWF3JyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWF3JyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWF3JyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:54:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932412AbWF3JyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:54:12 -0400
Subject: Re: 2.6.17-mm4
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <1151662073.31392.4.camel@localhost.localdomain>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
	 <20060629204330.GC13619@redhat.com> <20060629210950.GA300@elte.hu>
	 <20060629230517.GA18838@elte.hu>
	 <1151662073.31392.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 11:54:02 +0200
Message-Id: <1151661242.11434.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 11:07 +0100, Alan Cox wrote:
> Ar Gwe, 2006-06-30 am 01:05 +0200, ysgrifennodd Ingo Molnar:
> > it does things like:
> > 
> >         static const unsigned long qd_port[2] = { 0x30, 0xB0 };
> >         static const unsigned long ide_port[2] = { 0x170, 0x1F0 };
> > 
> >         [...]
> >                 unsigned long port = qd_port[i];
> >         [...]
> >                         r = inb_p(port);
> >                         outb_p(0x19, port);
> >                         res = inb_p(port);
> >                         outb_p(r, port);
> > 
> > so it reads/writes port 0x30 and 0xb0. Are those used by something else 
> > on modern hardware?
> 
> Not especially. Perhaps the best thing to do here would be to make qdi
> compiled into the kernel (as opposed to modular) only do so if
> "probe_qdi=1" or similar is set.

another quick hack is to check for vesa lb... eg if pci is present, skip
this thing entirely :)


