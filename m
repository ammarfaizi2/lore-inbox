Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271086AbRHOIXg>; Wed, 15 Aug 2001 04:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271088AbRHOIXQ>; Wed, 15 Aug 2001 04:23:16 -0400
Received: from [195.66.192.167] ([195.66.192.167]:14602 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271086AbRHOIXK>; Wed, 15 Aug 2001 04:23:10 -0400
Date: Wed, 15 Aug 2001 11:25:14 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <509636476.20010815112514@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: SAK killing daemons
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that when I press SAK on virtual console #1
on my Linux box, some daemons die horribly (SIGKILLed)
and some are unaffected. This does not happen on other consoles.

I suppose dying daemons did not detach fully from controlling tty. And
since they were launched from virtual console #1 upon system startup,
SAK killed them.

Daemons dying upon SAK: syslogd mysqld top* logger*
Daemons surviving SAK: klogd gpm dhcpcd inetd automount

* these are not daemons, but I intend them to run continuously.
logger directs mysqld output to syslog, and I keep top on console #10:
su user0 -c "top s </dev/tty10 >/dev/tty10 &"

Also I see '?' in TTY column in 'ps -AH e' output for all these
daemons (both dying and surviving), so ps does not provide any hint...

Does anybody knows a way to write a helper script to detach
misbehaving daemons (or any normal process like top) from tty on startup?
BTW, do syslogd needs fixing to be immune to SAK like klogd?

Please CC me. I'm not on the list.
-- 
Best regards,
VDA                          mailto:VDA@port.imtp.ilyichevsk.odessa.ua


