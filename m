Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSKNBJk>; Wed, 13 Nov 2002 20:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSKNBJk>; Wed, 13 Nov 2002 20:09:40 -0500
Received: from fmr06.intel.com ([134.134.136.7]:18414 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261205AbSKNBJj>; Wed, 13 Nov 2002 20:09:39 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000F866078@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: local APIC may cause XFree86 hang
Date: Wed, 13 Nov 2002 17:16:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The one instance I saw was that the BIOS was reading 8254 in a tight loop
for a calibration purpose, and it was assuming the time proceeded in a
constant speed, to exit the loop. In other words, it never assumed it could
get interrupts. To vm86, interrupts are invisible, but they have impacts on
the actual speed. 

Jun

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> Sent: Wednesday, November 13, 2002 4:48 PM
> To: Nakajima, Jun
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: local APIC may cause XFree86 hang
> 
> 
> On Wed, 13 Nov 2002, Nakajima, Jun wrote:
> >
> > Are we disabling vm86 code to access to PIT or PIC? I saw some video ROM
> > code (either BIOS call or far call) did access PIT, confusing the OS.
> 
> Well, the kernel itself doesn't actually disable/enable anything, it
> leaves that decision to the caller.
> 
> XFree86 obviously does have IO rights, and I suspect it may allow the
> video BIOS to do just about anything, simply because it doesn't have much
> choise (the video bios clearly needs a lot of IO privileges too). So yes,
> that could easily confuse the OS if it happens, but it should be
> independent of IO-APIC vs not.
> 
> 		Linus
