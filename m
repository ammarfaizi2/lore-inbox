Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTJFQrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJFQrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:47:24 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:31933 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262240AbTJFQrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:47:22 -0400
Date: Mon, 6 Oct 2003 18:46:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: John Bradford <john@grabjohn.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       Dave Jones <davej@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <Pine.LNX.4.53.0310061157090.9590@chaos>
Message-ID: <Pine.GSO.3.96.1031006182459.18687F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Richard B. Johnson wrote:

> >  Huh?  The floppies use ordinary I/O ports at the ISA bus, not the range
> > reserved for motherboard devices as, until quite recently, FDCs used to
> > exist solely as add-on cards (I still have one).  Any other ISA device is
> > free to use the port range if it's unused by anything else (e.g. no FDC
> > there).  Ditto for IRQ6 -- older cards used to have an option to use this
> > line, only newer ones often do not have it anymore, for unknown reason
> > (i.e. the cost is probably one).
> 
> No. The range of addresses for floppy disk controllers is
> "reserved" for floppy disk controllers. That's the rule for
> IBM/PC/AT/Intel compatible devices. This is specified in
> the literature like that written by Phoenix, IBM, etc.
> (Phoenix Technical Reference Series, System BIOS for
> IBM PC/XT/AT and Compatible Computers.  ISBN 0-201-51806-6

 That means standard ISA FDCs, if present, will be just there, not
elsewhere.  This is needed for the MB BIOS to recognize the controllers,
but an add-on card with its own BIOS is free to use other addresses as
long as it appropriately hooks the BIOS int 0x13 chain.

> We have rules. That's what "Compatible" means. If you break
> the compatibility by putting something else at that address,
> you take your chances.

 You disable the port addresses for floppies either with the PC/XT
configuration switches or with appropriate settings in the BBU RAM area of
the RTC chip for PC/AT.  Compatibility is preserved by only using BIOS
calls and predefined variables.  This is especially needed for controllers
with own BIOSes.

> When the Super I/O chips are programmed, the floppy device,
> (usually logical device 0) is (must) be put at the base
> address reserved for floppy disks in compatible machines.

 That's no problem -- when you have standard ISA FDC devices to be handled
by the system BIOS, you have to put them at the predefined addresses.  Of
course these need not be the so called "super I/O" chips -- they may well
be the original NEC uPD765 ones or compatible substitutes. 

> For the architecture in the linux i386 subdirectory, which
> is what I was talking about, there will either be a FDC
> controller output register at 0x372, with the bits previously
> taught, or there will be nothing. It's that simple. If
> you make it more complicated, then you don't understand
> what compatibility means.

 You need to query the BIOS if standard ISA floppy drives are supported,
either via a call or checking the BIOS variable area.  If there is no
floppy drive at the expected address, you can only assume exactly that and
not that there's nothing decoding these addresses at all. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

