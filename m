Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270432AbTHCUfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHCUfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:35:43 -0400
Received: from mail.cyberus.ca ([209.195.118.111]:3344 "EHLO mail.cyberus.ca")
	by vger.kernel.org with ESMTP id S270432AbTHCUff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:35:35 -0400
Subject: Re: TOE brain dump
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Larry McVoy <lm@bitmover.com>
Cc: Erik Andersen <andersen@codepoet.org>,
       Werner Almesberger <werner@almesberger.net>,
       Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, Nivedita Singhvi <niv@us.ibm.com>
In-Reply-To: <20030803194011.GA8324@work.bitmover.com>
References: <20030802140444.E5798@almesberger.net>
	 <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com>
	 <20030802184901.G5798@almesberger.net> <3F2CAE61.7070401@pobox.com>
	 <20030803145737.B10280@almesberger.net>
	 <20030803182755.GA16770@codepoet.org>
	 <20030803194011.GA8324@work.bitmover.com>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1059942894.1103.96.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Aug 2003 16:34:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-03 at 15:40, Larry McVoy wrote:
> On Sun, Aug 03, 2003 at 12:27:55PM -0600, Erik Andersen wrote:
> > On Sun Aug 03, 2003 at 02:57:37PM -0300, Werner Almesberger wrote:
> > > > There is one interesting TOE solution, that I have yet to see created: 
> > > > run Linux on an embedded processor, on the NIC.
> > > 
> > > That's basically what I've been talking about all the
> > > while :-)
> > 
> > http://www.snapgear.com/pci630.html
> 
> ipcop plus a new PC for $200 is way higher performance and does more.

;-> Actually this proves that putting the whole stack on the NIC is the
wrong way to go ;-> That poor piece of NIC was obsoleted before it was
born on pricing alone and not just compute power it was supposed to
liberate us from.

I think the idea of hierachical memories and computation is certainly
interesting. Put a CPU and memory on the NIC but not to do the work that
Linux already does. Instead think of the NIC and its memeory + CPU as a
L1 data and code cache for TCP processing. The idea posed from Davem is
intriguing:
The only thing the NIC should do is TCP fast path processing based on
cached control data generated from the main CPU stack. Any time the fast
path gets violated, the cache gets invalidate and it becomes an
exception handling to be handled by the main CPU stack.

IMO, the only time this will make sense is when the setup cost
(downloading the cache or cookies as Dave calls them) is amortized by
the data that follows. For example, may not make sense to worry about a
HTTP1.0 flow which has 3-4 packets after the SYNack.Bulk transfers make
sense (storage, file serving). I dont remember the Mogul paper details
but i think this is what he was implying.

cheers,
jamal

