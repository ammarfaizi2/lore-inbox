Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSFMNav>; Thu, 13 Jun 2002 09:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSFMNau>; Thu, 13 Jun 2002 09:30:50 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:10368 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S317604AbSFMNat>; Thu, 13 Jun 2002 09:30:49 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Helge Hafting'" <helgehaf@aitel.hist.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: The buggy APIC of the Abit BP6
Date: Thu, 13 Jun 2002 15:30:20 +0200
Message-ID: <003601c212de$77316240$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <3D08603E.91DE5C75@aitel.hist.no>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> > Jun 12 23:47:56 radium kernel: unexpected IRQ trap at vector 7d
> > Jun 12 23:47:56 radium kernel: unexpected IRQ trap at vector 7d
> 
> It _can_ be solved - rebooting cures it, so assuming the problem
> is autodetectable it _can_ be solved by doing whatever it is
> a reboot (or driver reload) does to the APIC.

True.

> My guess is that the APIC setup for that IRQ have to be reprogrammed.
> you could do that as a quirk for the BP6.
> The first question is if there is a reliable way to detect this
> condition.  "No interrupts from a device" could simply mean that
> it isn't used much at the time.  You get a unexpected IRQ trap - do
> the problem always manifest itself this way?

Yes, I always get the "unexpected IRQ trap at vector 7d" message. This
is the same message even with different NICs (though they were placed in
the same PCI slot). About 30-120 seconds after this message (depending
on some driver timeout value I guess) the NETDEV watchdog kicks in with
a "eth0: transmit timed out".

> The second question is if all the PCI card drivers out there
> survive a lost interrupt handled outside the driver.  
> If not, you have to close+reopen the device, and that involves
> userspace.
> A network card will need reinitialization, a disk controller
> remounting...

That could indeed be a problem. But this will become clear pretty soon
once this APIC reprogramming workaround is actually implemented in the
kernel. Then I will be able to test that. Any ideas how this workaround
in the kernel would look like?

Thanks for the help,
- Robbert Kouprie

