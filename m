Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262236AbSJHMGm>; Tue, 8 Oct 2002 08:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbSJHMGm>; Tue, 8 Oct 2002 08:06:42 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:23033 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262236AbSJHMGl>; Tue, 8 Oct 2002 08:06:41 -0400
Subject: Re: [patch] IDE driver model update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0210072126380.29030-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0210072126380.29030-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 13:21:08 +0100
Message-Id: <1034079668.26550.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 03:17, Alexander Viro wrote:
> _ALL_ buses that have driverfs support (IDE, SCSI, USB, PCI) have their
> own rules for lifetimes of their structures.  And that's not likely to
> change - these objects belong to drivers and in some cases (IDE) are
> not even allocated dynamically - they are reused if nothing is holding
> them.

IDE objects can also outlast the hardware - consider an active mount on
an ejected pcmcia card. Right now we don't do the right stuff to
reconnect that on re-insert but one day we may need to. As it is we keep
the instance around to avoid crashes

