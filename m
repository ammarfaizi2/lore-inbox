Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSIWVlv>; Mon, 23 Sep 2002 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbSIWVkd>; Mon, 23 Sep 2002 17:40:33 -0400
Received: from magic.adaptec.com ([208.236.45.80]:30935 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261462AbSIWVj0>; Mon, 23 Sep 2002 17:39:26 -0400
Date: Mon, 23 Sep 2002 15:43:16 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid
 SCB 0
Message-ID: <2632550816.1032817396@aslan.btc.adaptec.com>
In-Reply-To: <20020923063531.30270@192.168.4.1>
References: <Pine.LNX.4.44.0209231350390.973-100000@freak.distro.conectiva>
 <20020923063531.30270@192.168.4.1>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Thanks for explaining me the issue clearly. :)
> 
> Hi Justin ! What is the actual breakage here ? Is this just PCI write
> posting ? (that is PCI writes staying in bridge write buffer for
> some time until you flush the whole path with a read). In this
> case those intel & VIA chipsets aren't at fault as this is perfectly
> legal per PCI spec and we'll have problem with all other sort of
> machines, especially machines with stacked PCI<->PCI bridges like
> it's the case for most pmacs.

No, it is not write posting.  It is usually a problem with write
combining/merging and or read prefetch on devices that do not
support this feature.  The memory BAR on the aic7xxx chips does
not have the PREFETCH bit set so these types of operations are
forbidden by the spec.  The end result are missed writes and
state read data leading to all kinds of driver confusion.

Often these issues are really register layout dependent.  If
you never have to access two registers that are right next to
each other, the chipset can't write combine, etc.

--
Justin

