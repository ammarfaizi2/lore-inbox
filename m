Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbRBNP4b>; Wed, 14 Feb 2001 10:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129399AbRBNP4V>; Wed, 14 Feb 2001 10:56:21 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:61711 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129354AbRBNP4R>;
	Wed, 14 Feb 2001 10:56:17 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jes Sorensen <jes@linuxcare.com>
Date: Wed, 14 Feb 2001 16:54:22 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        becker@scyld.com
X-mailer: Pegasus Mail v3.40
Message-ID: <157828DC5517@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Feb 01 at 16:35, Jes Sorensen wrote:
> >>>>> "Donald" == Donald Becker <becker@scyld.com> writes:
> Donald> On 12 Feb 2001, Jes Sorensen wrote:

> Donald> ???  - It's not just IPX hosts that send 802.3 headers.  -
> Donald> While a good initial value might depend on the architecture,
> Donald> the best setting is processor implementation and environment
> Donald> dependent.  Those details are not known at compile time.  -
> Donald> The code path cost of a module option is only a compare and a
> Donald> conditional branch.
> 
> What else is sending out 802.3 frames these days? I really don't care
> about IPX when it comes to performance.
> 
> I am just advocating that we optimize for the common case which is DIX
> frames and not 802.3.

Pardon me, but IPX in 802.3 and IPX in DIX are exactly same frames
on wire, except that IPX/802.3 contains frame length in bytes
0x0C/0x0D, while IPX/DIX contains 0x8137 here. They have same length,
and same length of media header, so I really do not understand.

If you are talking about encapsulation which is known as `ethernet_802.2' 
in IPX world, then it is true, it has odd bytes in header. But nobody sane 
except Appletalk uses 802.2 now... Our Suns already died due to this couple 
of years ago ;-)

And as Ethernet SNAP has 8byte long header, it should be safe too, unless
architecture requires 16byte alignment - so only odd 802.2 should
be baned.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
