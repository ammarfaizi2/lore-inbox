Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264460AbRFOXOn>; Fri, 15 Jun 2001 19:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264568AbRFOXOX>; Fri, 15 Jun 2001 19:14:23 -0400
Received: from ruckus.brouhaha.com ([209.185.79.17]:64701 "HELO brouhaha.com")
	by vger.kernel.org with SMTP id <S264563AbRFOXOO>;
	Fri, 15 Jun 2001 19:14:14 -0400
Date: 15 Jun 2001 23:14:13 -0000
Message-ID: <20010615231413.17697.qmail@brouhaha.com>
From: Eric Smith <eric@brouhaha.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6-Jun-2001, I reported:
> I upgraded my IBM ThinkPad 240 (Type 2609-31U) from Red Hat 7.0 to
> Red Hat 7.1, which uses the 2.4.2 kernel and the kernel PCMCIA drivers.
> Before the upgrade, all my CardBus and PCMCIA devices were working fine.
> Now the yenta_socket module seems to be causing problems, and none of
> the cards work.

Arjan van de Ven of Red Hat tracked my problem down to a broken BIOS,
which is not configuring the TI PC1211 CardBus bridge correctly.  Even
IBM's latest BIOS for the ThinkPad 240, IRET75WW released 17-May-2001,
has this problem.  Apparently IBM has issued fixes for other ThinkPads
because the problem occurs with Windows 2000, but since Windows 2000 is
not supported on the ThinkPad 240, it is unlikely that they will fix it.

A one line change to linux/include/asm-i386/pci.h fixes it:

-#define pcibios_assign_all_busses()	0
+#define pcibios_assign_all_busses()	1

Given that this macro exists, I surmise that other people have been
bitten by similar problems.  So now my question is:

Does it make sense to turn pcibios_assign_all_busses into a variable
with a default value of zero, and implement a kernel argument to set it?
That way people with broken BIOSes could solve it by simply adding the
argument in their lilo.conf.  In an ideal world the BIOSes would get
fixed and such a workaround would be unnecessary, but in my experience
trying to get a vendor to fix a BIOS problem is an exercise in futility.

If no one is opposed to my proposed change, I'll be happy to generate a
suitable patch and send it in.

Thanks!
Eric Smith
