Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSKNICY>; Thu, 14 Nov 2002 03:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSKNICY>; Thu, 14 Nov 2002 03:02:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30968 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264788AbSKNICX>;
	Thu, 14 Nov 2002 03:02:23 -0500
Message-ID: <3DD35A13.9600BF75@mvista.com>
Date: Thu, 14 Nov 2002 00:08:51 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: local APIC may cause XFree86 hang
References: <Pine.LNX.4.44.0211131735490.6810-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 13 Nov 2002, Nakajima, Jun wrote:
> >
> > The one instance I saw was that the BIOS was reading 8254 in a tight loop
> > for a calibration purpose, and it was assuming the time proceeded in a
> > constant speed, to exit the loop. In other words, it never assumed it could
> > get interrupts. To vm86, interrupts are invisible, but they have impacts on
> > the actual speed.
> 
> That sound slike a perfectly ok thing to do - apart from the hw latching
> which might confuse the kernel.

Yes, it has been speculated that some "time warps" were
caused by "someone" reading only one of the two bytes from
the PIT.  It puts the following reads out of sync.  If this
was caused by an interrupt (which, of course, is where the
PIT is read by the kernel) between two reads, it could well
cause the "time warps" that have been observed.

George
> 
> When enabling the local APIC, Linux doesn't actually disable legacy PIT
> interrupts, so again I don't really see what the apparent connection
> between the hang and the APIC is. So I'd still suspect it's more
> timing-related than anything else.
> 
>                 Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
