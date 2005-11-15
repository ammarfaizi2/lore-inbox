Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVKOFFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVKOFFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVKOFFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:05:22 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:8458 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932517AbVKOFFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:05:22 -0500
Message-ID: <43796C76.8070603@tuxrocks.com>
Date: Mon, 14 Nov 2005 22:04:54 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>	 <4378FFFF.4010706@tuxrocks.com> <1132004327.4668.30.camel@leatherman>	 <4379074D.5060308@tuxrocks.com> <1132005736.4668.34.camel@leatherman>	 <437918A0.8000308@tuxrocks.com> <1132010724.4668.40.camel@leatherman>
In-Reply-To: <1132010724.4668.40.camel@leatherman>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> Hrm.. How about sending a dmesg of just vanilla 2.6.14-mm2? Also does
> the behavior change booting w/ idle=poll ?

idle=poll does seem to fix the major clock drift problem.  There may
still be an issue, but it's much smaller:

2.6.14-mm2-todb10:
14 Nov 21:50:57      offset: -0.025373       drift: -22404.0 ppm
14 Nov 21:51:59      offset: -1.577053       drift: -24985.4603175 ppm
14 Nov 21:53:00      offset: -3.104569       drift: -25012.9032258 ppm

2.6.14-mm2-todb10 with idle=poll:
14 Nov 21:37:59      offset: 5.9e-05         drift: 63.0 ppm
14 Nov 21:39:00      offset: 0.003207        drift: 51.7903225806 ppm
14 Nov 21:40:00      offset: 0.012048        drift: 98.7868852459 ppm
14 Nov 21:41:00      offset: 0.020439        drift: 112.324175824 ppm
14 Nov 21:42:00      offset: 0.023596        drift: 97.520661157 ppm
14 Nov 21:43:00      offset: 0.026723        drift: 88.5 ppm
14 Nov 21:44:00      offset: 0.029856        drift: 82.4861878453 ppm
14 Nov 21:45:01      offset: 0.033036        drift: 78.1087470449 ppm

> Thanks so much for the problem report and testing, btw!

I just hope it helps! :)

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDeWx2aI0dwg4A47wRAtVoAJ9OmWr3FYTDMBcrUBSAY6NYoq7naACff+eX
jZ4Z8+uGxRXOtTCaoUWd2ns=
=S5T6
-----END PGP SIGNATURE-----
