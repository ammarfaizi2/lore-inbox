Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbQL1Kxy>; Thu, 28 Dec 2000 05:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbQL1Kxp>; Thu, 28 Dec 2000 05:53:45 -0500
Received: from p3EE3C855.dip.t-dialin.net ([62.227.200.85]:24836 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129775AbQL1Kxh>; Thu, 28 Dec 2000 05:53:37 -0500
Date: Thu, 28 Dec 2000 11:23:05 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre3
Message-ID: <20001228112305.A2571@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001228021859.A4661@emma1.emma.line.org> <E14BSwU-00038p-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14BSwU-00038p-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 28, 2000 at 02:37:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Alan Cox wrote:

> > > o	VIA686a timer reset to 18Hz background		(Vojtech Pavlik)
> > 
> > I patched my 2.2.18-ma2 with that patch to see if that helps me off my
> > sys time slowness, but it does unfortunately not help.
> 
> Thats unrelated

Ok, that's what I eventually figured by looking at the code as well.

> > I have my system clock drift roughly -1 s/min, though my CMOS clock is
> > fine unless tampered with.
> 
> Unless its a driver holding off irqs for a long time your only option is
> probably to replace the crystals on the board with ones that are more
> accurate.

Wait a minute, this is a new board. I had a suspicion, and I have a new
suspect, can we investigate this?

I have used the same kernel, with the VIA 686a patch, but left some
config options out:

# diff -U1 -Nur <(egrep -v '^(#|$)' linux-2.2.18-ma3/.config) <(egrep -v
'^(#|$)' linux-2.2.18-try/.config)
--- /dev/fd/63  Thu Dec 28 11:20:05 2000
+++ /dev/fd/62  Thu Dec 28 11:20:05 2000
@@ -30,6 +30,2 @@
 CONFIG_PARPORT_PC=m
 -CONFIG_APM=y
 -CONFIG_APM_CPU_IDLE=y
 -CONFIG_APM_DISPLAY_BLANK=y
 -CONFIG_APM_RTC_IS_GMT=y
  CONFIG_BLK_DEV_FD=y

I rebooted, and since I left APM out, the system clock is alright since
63 mins. Might the APM BIOS CPU IDLE calls be related? I did *not* enable
CONFIG_APM_ALLOW_INTS. I'll investigate this right now and report back
what I find.

> adjtimex will let you tell Linux the clock on the board is crap too

Where is the source for the adjtimex /program/? SuSE don't bring
adjtimex.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
