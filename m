Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQL1OYe>; Thu, 28 Dec 2000 09:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbQL1OYZ>; Thu, 28 Dec 2000 09:24:25 -0500
Received: from p3EE3C765.dip.t-dialin.net ([62.227.199.101]:14084 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129823AbQL1OYN> convert rfc822-to-8bit; Thu, 28 Dec 2000 09:24:13 -0500
Date: Thu, 28 Dec 2000 14:53:37 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20001228145337.A2887@emma1.emma.line.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001228112305.A2571@emma1.emma.line.org> <E14Bc2d-0003e0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Bc2d-0003e0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 28, 2000 at 12:20:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Alan Cox wrote:

> > CONFIG_APM_ALLOW_INTS. I'll investigate this right now and report back
> > what I find.
> 
> That would be interesting

Forget this all.

I found the problem trigger, it's reading from /proc/apm, for a reason I
cannot currently see.

Current config, as far as it's APM-related:
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
# CONFIG_TOSHIBA is not set

I had found out that my clock was slow while dnetc was running. I had a
dummy loader that just did while(1) {} which did not slow my clock. Now, I
straced that dnetc beast and found out that it reads /proc/apm quite
often.

I can have my clock almost halt with this one:

while cat /proc/apm ; do : ; done

If I leave this running for 15 s, my system time drifts back 11½ s.


Relevant dmesg:
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)


Board: Gigabyte 7ZXR, BIOS rev. F4 (VIA KT133 chip set, AMIBIOS).



I can and will test further, also with recompiled kernels, but I need
directions what to test.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
