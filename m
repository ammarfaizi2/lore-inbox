Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271153AbRHOLpX>; Wed, 15 Aug 2001 07:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271152AbRHOLpN>; Wed, 15 Aug 2001 07:45:13 -0400
Received: from [195.66.192.167] ([195.66.192.167]:53517 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271153AbRHOLpA>; Wed, 15 Aug 2001 07:45:00 -0400
Date: Wed, 15 Aug 2001 14:47:17 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <9221759778.20010815144717@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: SAK killing daemons
In-Reply-To: <20010815104413.B13330@pasky.ji.cz>
In-Reply-To: <509636476.20010815112514@port.imtp.ilyichevsk.odessa.ua>
 <20010815104413.B13330@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Petr,
Wednesday, August 15, 2001, 11:44:13 AM, you wrote:
>> I noticed that when I press SAK on virtual console #1
>> on my Linux box, some daemons die horribly (SIGKILLed)
>> and some are unaffected. This does not happen on other consoles.
>> I suppose dying daemons did not detach fully from controlling tty. And
>> since they were launched from virtual console #1 upon system startup,
>> SAK killed them.
>> Daemons dying upon SAK: syslogd mysqld top* logger*
>> Daemons surviving SAK: klogd gpm dhcpcd inetd automount
>
> Try running the dying daemons by setsid utility (man 1 setsid, man 2 setsid),
> it can help maybe. And try to modify that su -c command to:
>
> su user0 -c "top s" </dev/tty/10 >/dev/tty10 2>/dev/tty10 &
>
> that could help also.

Okay, tried that with top and it works. However, syslogd still
misbehaves. I tried these:

/usr/sbin/syslogd
setsid /usr/sbin/syslogd </dev/null >/dev/null 2>&1
setsid /usr/sbin/syslogd -n </dev/null >/dev/null 2>&1 &

with no success.
Does ANYBODY have syslogd which does NOT die after SAK on VT #1 ?
If so, please tell me how exactly do you launch it,
syslogd and kernel version. Mine:
syslogd: 1.4.1
kernel: 2.4.5

Note: klogd does not die. Looking at the sources, I don't see why.
They use similar method (however not identical code) of auto-backgrounding
but... maybe someone more experienced can take a look?

Please CC me, I'm not on the list.
-- 
Best regards,
VDA                            mailto:VDA@port.imtp.ilyichevsk.odessa.ua


