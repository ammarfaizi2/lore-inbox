Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbRADSXa>; Thu, 4 Jan 2001 13:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbRADSXV>; Thu, 4 Jan 2001 13:23:21 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:7433 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131161AbRADSWu>; Thu, 4 Jan 2001 13:22:50 -0500
Message-ID: <3A54CD80.4A163381@t-online.de>
Date: Thu, 04 Jan 2001 20:22:40 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: linux-parport@torque.net, linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <200101041530.JAA92328@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> Originally, (wayback machine on) this was handled by a pull-up resistor
> in the parallel interface, on the "off-line" signal. ANY time the printer
> was powered off, set offline, or cable unplugged, the "off-line" signal
> was raised by the pull-up. No data lost.
> 
> Now the parallel interface is bidirectional, and can have multiple devices
> attached - this "fix" cannot be used. The interface is now more of a
> buss than a single attached interface, and signals from a missing device
> (powered off or disconnected) are floating. They may float high or low,
> and depending on the environment (and which end of the cable is unplugged)
> any thing in between.

Not true. Electrical characteristics for parallel port implementations/cards
differ wildly, nevertheless most implementations have:
- data lines: bidirectional (see datasheets)
- signal lines: see datasheets, never floating !

Floating signal lines are a silicon bug/bad engineering and have nothing
to do with bidirectional interfaces ! 

Nowadays most integrated chips have internal signal line pull-ups internally, e.g. 
W83877TF says:
-BUSY, ACK, PE, SLCT, ERR:
  TTL level input pin. This pin is pulled high internally.
-AFD, STB, INIT, SLIN
  Open-drain output pin with 12 mA sink capability. Pulled up internally.
-Data lines:
  TTL level bi-directional with 24 mA source-sink capability.

Of course I would expect add-in cards to exist, with not so sophisticated chipsets
and makers that have "forgotten" external pull-ups for economical reasons (2 cents :-)
We should NOT care for broken hardware !!! I haven't seen any of these yet, even.

On the other hand printer implmentations vary wildly, too.
LJ1100: leave signal lines alone if powered off (0x7f)
    i.e. signal printer-not-ready ack-active out-of-paper
DJ500: signal printer-error and off-line when powered off (0x87) !!!
    => Linux would dump data on this printer, if switched off.

I think the current linux lp code tries to handle exotic/weird printers 
gracefully and leaves mainstream printers and users alone.
-
Gunther
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
