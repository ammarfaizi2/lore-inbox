Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267918AbTB1OIp>; Fri, 28 Feb 2003 09:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267919AbTB1OIp>; Fri, 28 Feb 2003 09:08:45 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:16372 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267918AbTB1OIo>;
	Fri, 28 Feb 2003 09:08:44 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15967.28629.35699.473056@gargle.gargle.HOWL>
Date: Fri, 28 Feb 2003 15:19:01 +0100
To: fauxpas@temp123.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: IOAPIC on Via KT266a
In-Reply-To: <20030227165248.GA12030@temp123.org>
References: <20030227165248.GA12030@temp123.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fauxpas@temp123.org writes:
 > I have a UP system with Via kt266a chipset.  When I enable APIC in
 > the BIOS and in Linux, the system boots mostly normally, but I get
 > a fairly constant stream of
 > 
 > APIC error on CPU0: 02(02)
 > 
 > with a smattering of other numeric codes from time to time.  Most
 > things still work, but there are a number of oddities and instabilities,
 > most notably my integrated uhci USB controllers give usb bulk-msg
 > timeouts on every device.

02 is "Receive Checksum Error", and it's explained both in apic.c
and in Intel's IA32 Volume 3 manual.

This is almost certainly a hardware problem: your machine's APIC bus
is corrupting messages, or some other agent than the CPU is creating
corrupt messages. This isn't exactly unheard of for non-Intel chipsets.

Disable IO_APIC support and you should be fine. If you still get these
errors, you'll have to either live with them or disable UP local APIC
support as well.

/Mikael
