Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130767AbQL2NSv>; Fri, 29 Dec 2000 08:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130886AbQL2NSl>; Fri, 29 Dec 2000 08:18:41 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:24836 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130767AbQL2NSc>; Fri, 29 Dec 2000 08:18:32 -0500
Date: Fri, 29 Dec 2000 13:42:52 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: matthias.andree@stud.uni-dortmund.de
Cc: alan@lxorguk.ukuu.org.uk,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20001229134252.L22081@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001228112305.A2571@emma1.emma.line.org> <E14Bc2d-0003e0-00@the-village.bc.nu> <20001228145337.A2887@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001228145337.A2887@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Dec 28, 2000 at 02:53:37PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 02:53:37PM +0100, Matthias Andree wrote:
> Forget this all.
> 
> I found the problem trigger, it's reading from /proc/apm, for a reason I
> cannot currently see.
> 
> Current config, as far as it's APM-related:
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> # CONFIG_APM_CPU_IDLE is not set
> # CONFIG_APM_DISPLAY_BLANK is not set
> CONFIG_APM_RTC_IS_GMT=y
> CONFIG_APM_ALLOW_INTS=y
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> # CONFIG_TOSHIBA is not set
> 
> I had found out that my clock was slow while dnetc was running. I had a
> dummy loader that just did while(1) {} which did not slow my clock. Now, I
> straced that dnetc beast and found out that it reads /proc/apm quite
> often.

I got the same problem while running the GNOME battery_applet, which
checks /proc/apm every 2 seconds.

> I can have my clock almost halt with this one:
> 
> while cat /proc/apm ; do : ; done
> 
> If I leave this running for 15 s, my system time drifts back 11½ s.

Same over here on an Asus M8300 notebook (Celeron 500, 128MB, Intel
440MX chipset). Output from /proc/apm:

  1.14 1.2 0x03 0x01 0x03 0x09 100% -1 ?

I also enabled CONFIG_APM_ALLOW_INTS to see if it makes any difference,
but apparently it doesn't.

However, reading from /proc/apm also triggers other weird problems:

- Sound hickups: mp3 output starts to sound "scratchy". problem
  disappears after restarting mp3 player or after a couple of reads
  from /proc/apm. This is with mpg123, xmms, and madplay.
- USB drop outs, especially for bulk devices like scanners or USB audio
  devices. For sound it usually takes a second or so to restart.
- Received characters dropped on serial line. I thought my serial port
  was broken, because a 16550 is supposed to have a receive buffer.

All these problems went away when I removed the GNOME battery_applet.

I got the same problems with my previous notebook (Asus P6300, PII 266,
112MB, Intel BX/ZX chipset). It might be a BIOS problem, because both
notebooks use a Phoenix BIOS. OTOH, I can create the same problems with
USB on my desktop (Asus P5A motherboard, K6 333, 160MB, Ali 1541
chipset, Award BIOS) when I run the GNOME battery_applet. So is this an
Asus problem, or a general APM problem?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
