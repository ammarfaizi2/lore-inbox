Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271102AbRHOIoQ>; Wed, 15 Aug 2001 04:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271095AbRHOIoG>; Wed, 15 Aug 2001 04:44:06 -0400
Received: from pasky.ji.cz ([62.44.12.54]:505 "HELO pasky.ji.cz")
	by vger.kernel.org with SMTP id <S271102AbRHOIoB>;
	Wed, 15 Aug 2001 04:44:01 -0400
Date: Wed, 15 Aug 2001 10:44:13 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SAK killing daemons
Message-ID: <20010815104413.B13330@pasky.ji.cz>
Mail-Followup-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <509636476.20010815112514@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <509636476.20010815112514@port.imtp.ilyichevsk.odessa.ua>; from VDA@port.imtp.ilyichevsk.odessa.ua on Wed, Aug 15, 2001 at 11:25:14AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that when I press SAK on virtual console #1
> on my Linux box, some daemons die horribly (SIGKILLed)
> and some are unaffected. This does not happen on other consoles.
> 
> I suppose dying daemons did not detach fully from controlling tty. And
> since they were launched from virtual console #1 upon system startup,
> SAK killed them.
> 
> Daemons dying upon SAK: syslogd mysqld top* logger*
> Daemons surviving SAK: klogd gpm dhcpcd inetd automount
> 
> * these are not daemons, but I intend them to run continuously.
> logger directs mysqld output to syslog, and I keep top on console #10:
> su user0 -c "top s </dev/tty10 >/dev/tty10 &"
> 
> Also I see '?' in TTY column in 'ps -AH e' output for all these
> daemons (both dying and surviving), so ps does not provide any hint...
> 
> Does anybody knows a way to write a helper script to detach
> misbehaving daemons (or any normal process like top) from tty on startup?
> BTW, do syslogd needs fixing to be immune to SAK like klogd?
> 
> Please CC me. I'm not on the list.

Try running the dying daemons by setsid utility (man 1 setsid, man 2 setsid),
it can help maybe. And try to modify that su -c command to:

su user0 -c "top s" </dev/tty/10 >/dev/tty10 2>/dev/tty10 &

that could help also.

-- 

				Petr "Pasky" Baudis
.                                                                       .
#define BITCOUNT(x)     (((BX_(x)+(BX_(x)>>4)) & 0x0F0F0F0F) % 255)
#define  BX_(x)         ((x) - (((x)>>1)&0x77777777)                    \
                             - (((x)>>2)&0x33333333)                    \
                             - (((x)>>3)&0x11111111))
             -- really weird C code to count the number of bits in a word
.                                                                       .
My public PGP key is on: http://pasky.ji.cz/~pasky/pubkey.txt
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s++:++ a--- C+++ UL++++$ P+ L+++ E--- W+ N !o K- w-- !O M-
!V PS+ !PE Y+ PGP+>++ t+ 5 X(+) R++ tv- b+ DI(+) D+ G e-> h! r% y?
------END GEEK CODE BLOCK------
