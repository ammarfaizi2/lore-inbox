Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbTAGSJZ>; Tue, 7 Jan 2003 13:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTAGSJZ>; Tue, 7 Jan 2003 13:09:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39438 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267564AbTAGSJY>; Tue, 7 Jan 2003 13:09:24 -0500
Date: Tue, 7 Jan 2003 09:44:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Grant Grundler <grundler@cup.hp.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
In-Reply-To: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Jan 2003, Alan Cox wrote:
>
> On Tue, 2003-01-07 at 00:13, Grant Grundler wrote:
> > On Mon, Jan 06, 2003 at 03:19:09PM -0800, Linus Torvalds wrote:
> > > In particular, we can make the first phase disable DMA on the devices we 
> > > find, which means that we know they won't be generating PCI traffic during 
> > > the second phase - so now the second phase (which does the BAR sizing) can 
> > > do sizing and be safe in the knowledge that there should be no random PCI 
> > > activity ongoing at the same time.
> > 
> > Did you expect the PCI_COMMAND_MASTER disabled in the USB Controller
> > or something else in the controller turned off?
> 
> There is another problem too. Some devices ignore the master bit disable.
> VIA 8233/8235 being a fine example.

Well, I was actually thinking of really _stopping_ the USB controller and
disable DMA that way.  That's easy to do with a few trivial fixups - one
for each USB controller type (and there are only three).

Because of legacy USB handling by the SMM BIOS, USB really ends up being a
special case. There may be other special cases, of course, but the whole 
point of the fixups is exactly to handle special cases.

		Linus

