Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319056AbSHMUUx>; Tue, 13 Aug 2002 16:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSHMUUx>; Tue, 13 Aug 2002 16:20:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21511 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319056AbSHMUUv>; Tue, 13 Aug 2002 16:20:51 -0400
Date: Tue, 13 Aug 2002 13:26:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
In-Reply-To: <1029269633.22847.92.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208131323250.1260-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Aug 2002, Alan Cox wrote:
> > 
> > OK, that IDE thing smacks of unmitigated evil to me, but if things are relying 
> > on it, we shouldn't change it.
> 
> It wants to force its own conf1/conf2 over the BIOS even if BIOS is
> preferred because some BIOSes dont honour the size requested and the
> hardware has bugs.
> 
> That to me says there may well be cleaner approaches.

The thing I liked about the separate structures for function pointers for 
conf1/conf2 is that I could at least _see_ that the IDE driver might some 
day be changed to just do

	..
	conf2_struct->pci_config_read_byte(..)
	..

even if (judging by past performance) this would never happen ;)

This is why I'd like to continue with the notion of having a well-defined 
structure that contains all the pointers (and one default case). Now, 
shrinking those structures down to 2 entries instead of 6 sounds like a 
fine idea to me, but short-circuiting them internally sounds bad because 
it loses the ability to use the pci config space functions independently 
of each other.

		Linus

