Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317451AbSFRPbY>; Tue, 18 Jun 2002 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317452AbSFRPbW>; Tue, 18 Jun 2002 11:31:22 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:10880 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S317451AbSFRPbT>; Tue, 18 Jun 2002 11:31:19 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Raphael Manfredi'" <Raphael_Manfredi@pobox.com>
Cc: "'Helge Hafting'" <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: RE: The buggy APIC of the Abit BP6
Date: Tue, 18 Jun 2002 17:30:45 +0200
Message-ID: <004001c216dd$1d24f520$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-reply-to: <3D09CB4F.B1913B95@aitel.hist.no>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Manfredi wrote:

> I also know is that it works for me. ;-)

I just triggered the bug using a couple of simultaneous "ping -f -s 10
host" commands, and the patched kernel indeed recovers from the bug with
a "kernel: Kicking IO-APIC IRQ 17:" message :)
Now if only we could call the recovery mechanism from the point where
the "unexpected IRQ trap at vector" message gets printed (in
arch/i386/kernel/irq.c:ack_none), then we would have a lot more generic
code for all kinds of devices. If we then surround it by an #ifdef
CONFIG_BROKEN_APIC like Helge suggested, there's more chance this patch
gets accepted.

Problem now is, in the ack_none function we only know about the
(illegal) vector we are getting, and not about the interrupt we need to
reset. Could there be some kind of link between these, so that
kick_IO_APIC_irq can be called from there?

- Robbert

