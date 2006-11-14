Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755257AbWKNE24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbWKNE24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 23:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbWKNE24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 23:28:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:63390 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1755257AbWKNE2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 23:28:55 -0500
Date: Tue, 14 Nov 2006 05:28:53 +0100
From: Petr Baudis <pasky@suse.cz>
To: =?iso-8859-1?Q?Jos=E9_Su=E1rez?= <j.suarez.agapito@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-dvb@linuxtv.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [linux-dvb] Avermedia 777 misbehaves after remote hack merged into v4l-dvb tree
Message-ID: <20061114042853.GF18879@pasky.or.cz>
References: <200611131711.46626.j.suarez.agapito@gmail.com> <4558DF23.5080207@linuxtv.org> <1163453015.26319.29.camel@201-2-70-92.bsace705.w.brasiltelecom.net.br> <200611140445.30269.j.suarez.agapito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611140445.30269.j.suarez.agapito@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 04:45:29AM CET, José Suárez wrote:
> At the moment I can't give the remote control a try because lirc doesn't 
> compile against version 2.6.18 of the kernel. If that lirc issue gets solved, 
> I will try to use it as soon as I can.

  Note that in lircd, you should use the input device driver
("devinput"). The saa7134 driver will create a random input event device
for the events; I use this udev rule to create a /dev/remote symlink
pointing at the right device:

	KERNEL="event*", SYSFS{name}="saa7134 IR*", NAME="input/%k", SYMLINK="remote"

  Furthermore, especially if you have problems with lircd, having the
full-blown daemon for the event interface may not be worth it. There is
a standalone inputlircd package containing a much simpler daemon which
is compatible with lirc client applications but takes the events just
from the input devices. You can run it e.g. like:

	/usr/sbin/inputlircd /dev/remote -g -m 0

  You can find an example mplayer lirc configuration at:

	http://pasky.or.cz/~pasky/dev/v4l/lircrc

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
