Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293736AbSCKXFF>; Mon, 11 Mar 2002 18:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293560AbSCKXEz>; Mon, 11 Mar 2002 18:04:55 -0500
Received: from CPE-203-51-27-33.nsw.bigpond.net.au ([203.51.27.33]:44271 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S293736AbSCKXEo>; Mon, 11 Mar 2002 18:04:44 -0500
Message-ID: <3C8D380A.166A7895@eyal.emu.id.au>
Date: Tue, 12 Mar 2002 10:04:42 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -pre3, with the new IDE code. It has been stable enough time in

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=indydog  -c -o indydog.o indydog.c
indydog.c:25: asm/sgi/sgimc.h: No such file or directory
indydog.c:31: warning: function declaration isn't a prototype
indydog.c: In function `indydog_ping':
indydog.c:32: dereferencing pointer to incomplete type
indydog.c: In function `indydog_open':
indydog.c:52: `KSEG1' undeclared (first use in this function)
indydog.c:52: (Each undeclared identifier is reported only once
indydog.c:52: for each function it appears in.)
indydog.c:54: dereferencing pointer to incomplete type
indydog.c:54: `SGIMC_CCTRL0_WDOG' undeclared (first use in this
function)
indydog.c:55: dereferencing pointer to incomplete type
indydog.c: In function `indydog_release':
indydog.c:72: dereferencing pointer to incomplete type
indydog.c:73: `SGIMC_CCTRL0_WDOG' undeclared (first use in this
function)
indydog.c:74: dereferencing pointer to incomplete type
make[2]: *** [indydog.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/char'


Now, I am on an i386 machine, and indydog.c looks like a foreign object
here.
Since I automatically select 'm' for all offered options (just for
testing)
I guess we have a bad dependency in the watchdog config (but I am only
guessing):

   dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
$CONFIG_SGI_IP22

Looks OK to me though. However CONFIG_SGI_IP22 is not set anywhere,
should
dep_tristate treat it as FALSE?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
