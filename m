Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbSKNNym>; Thu, 14 Nov 2002 08:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSKNNym>; Thu, 14 Nov 2002 08:54:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:52651 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263193AbSKNNyl>; Thu, 14 Nov 2002 08:54:41 -0500
Subject: Re: local APIC may cause XFree86 hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD35A13.9600BF75@mvista.com>
References: <Pine.LNX.4.44.0211131735490.6810-100000@home.transmeta.com> 
	<3DD35A13.9600BF75@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 14:27:22 +0000
Message-Id: <1037284042.15996.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-14 at 08:08, george anzinger wrote:
> Linus Torvalds wrote:
> > 
> > On Wed, 13 Nov 2002, Nakajima, Jun wrote:
> > >
> > > The one instance I saw was that the BIOS was reading 8254 in a tight loop
> > > for a calibration purpose, and it was assuming the time proceeded in a
> > > constant speed, to exit the loop. In other words, it never assumed it could
> > > get interrupts. To vm86, interrupts are invisible, but they have impacts on
> > > the actual speed.
> > 
> > That sound slike a perfectly ok thing to do - apart from the hw latching
> > which might confuse the kernel.
> 
> Yes, it has been speculated that some "time warps" were
> caused by "someone" reading only one of the two bytes from
> the PIT.  It puts the following reads out of sync.  If this
> was caused by an interrupt (which, of course, is where the
> PIT is read by the kernel) between two reads, it could well
> cause the "time warps" that have been observed.

The 2.5 kernel also has another bug in the way it handles the latches
reading the exact count value they wrap on. Some chips expose that value
momentarily before resetting

