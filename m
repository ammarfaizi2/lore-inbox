Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265900AbSKFSGO>; Wed, 6 Nov 2002 13:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265903AbSKFSGO>; Wed, 6 Nov 2002 13:06:14 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:13572 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265900AbSKFSGG>; Wed, 6 Nov 2002 13:06:06 -0500
Date: Wed, 6 Nov 2002 18:12:42 +0000
From: John Levon <levon@movementarian.org>
To: george anzinger <george@mvista.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
Message-ID: <20021106181242.GA94146@compsoc.man.ac.uk>
References: <3DC8AD8A.20494DC0@mvista.com> <15816.62663.166644.782004@kim.it.uu.se> <3DC9588D.C3574CB5@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC9588D.C3574CB5@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 09:59:41AM -0800, george anzinger wrote:

> So then the NMI checks for timer interrupts being serviced
> in this case?  But, still, why the turn off if the timer
> does not go thru the APIC?  The case this came up in is an
> SMP machine, but the test in apic.c shows that the PIT
> interrupt does not go thru the APIC.  Leaving NMI on seems
> to work, so I am wondering if this is just old code.

It seems that the test should be :

	if (nmi_watchdog == NMI_IO_APIC) {
		... disable it
	}

I don't think the perfctr watchdog would be affected by the code in
io_apic.c

(on a vaguely related note, booting with nmi_watchdog=2 on my SMP
machine gives high rates of nmis :

janus:~# cat /proc/interrupts | grep NMI ; sleep 1 ; cat /proc/interrupts | grep NMI
NMI:      88358      88358
NMI:      88432      88397

when the machine is compiling kernels. I dunno why ...)

regards
john

-- 
"When a man has nothing to say, the worst thing he can do is to say it
memorably."
	- Calvin Trillin
