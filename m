Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVCZOfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVCZOfo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVCZOfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:35:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27817 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262113AbVCZOfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:35:32 -0500
Subject: Re: 2.6.12-rc1 breaks dosemu
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bart Oldeman <bartoldeman@users.sourceforge.net>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux-msdos@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1111847336.8042.26.camel@laptopd505.fenrus.org>
References: <20050320021141.GA4449@stusta.de>
	 <1111824629.6293.19.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0503262009040.3040@enm-bo-lt.localnet>
	 <200503261449.46219.arnd@arndb.de>
	 <1111847336.8042.26.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Mar 2005 15:35:26 +0100
Message-Id: <1111847727.8042.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 15:28 +0100, Arjan van de Ven wrote:
> On Sat, 2005-03-26 at 14:49 +0100, Arnd Bergmann wrote:
> > On Sünnavend 26 März 2005 09:18, Bart Oldeman wrote:
> > > On Sat, 26 Mar 2005, Arjan van de Ven wrote:
> > > 
> > > > > eip: 0x000069ee  esp: 0xbfdbffcc  eflags: 0x00010246
> > > >
> > > > hmm interesting. Can you check if at the time of the crash, the esp is
> > > > actually inside the stack vma? If it's not, I wonder what dosemu does to
> > > > get its stack pointer outside the vma... (and on which side of the vma
> > > > it is)
> > 
> > The esp value is always slightly below the stack vma and above ld.so.
> > Running it a few times gives 
> > 
> > stack VMA         crash esp
> > bfc8f000-bfca4000 bfc5ffcc  
> 
> the esp is 0x2F034/192564 bytes below the stack vma. That is a lot! I
> vaguely remember linux having a limit to how much below the stack vma it
> will allow accesses to auto-grow the stack, but I forgot what that limit
> actually was. I wonder if dosemu is somehow getting away with assuming a
> certain alignment by accident and then being inside the kernel grow
> limit, while with randomisation the alignment is only 4Kb and somehow a
> bigger-than-expected auto-grow is needed.

hmm I just read back your first mail and it seems the actual memory
access isn't to the stack at all but to 0xffffff8e
sounds like dosemu had an internal underflow somewhere...


