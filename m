Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSLaPup>; Tue, 31 Dec 2002 10:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSLaPup>; Tue, 31 Dec 2002 10:50:45 -0500
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:51981 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S263246AbSLaPuo>; Tue, 31 Dec 2002 10:50:44 -0500
Subject: Recent 2.4.x PPP bug? (PPPIOCDETACH file->f_count=3)
To: linux-kernel@vger.kernel.org
Date: Tue, 31 Dec 2002 16:59:06 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E18TOnK-0007Tp-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Starting with recent 2.4.19 and 2.4.20 kernels, when any
one (or both) of my two permanent PPP connections goes
down (usually due to the ISP rebooting their equipment),
quite often something bad happens.

Dec 31 16:31:52 alf kernel: PPPIOCDETACH file->f_count=3
Dec 31 16:31:52 alf kernel: PPPIOCDETACH file->f_count=3

Dec 31 16:31:52 alf pppd[31783]: Hangup (SIGHUP)
Dec 31 16:31:52 alf pppd[31783]: Modem hangup
Dec 31 16:31:52 alf pppd[27363]: Hangup (SIGHUP)
Dec 31 16:31:52 alf pppd[27363]: Modem hangup
Dec 31 16:31:52 alf pppd[31783]: Connection terminated.
Dec 31 16:31:52 alf pppd[27363]: Connection terminated.
Dec 31 16:31:52 alf pppd[27363]: Connect time 3961.2 minutes.
Dec 31 16:31:52 alf pppd[27363]: Sent 12744359 bytes, received 11908495 bytes.
Dec 31 16:31:52 alf pppd[31783]: Connect time 3961.2 minutes.
Dec 31 16:31:52 alf pppd[31783]: Sent 13843367 bytes, received 38226866 bytes.
Dec 31 16:31:53 alf pppd[31783]: Couldn't release PPP unit: Invalid argument
Dec 31 16:31:53 alf pppd[27363]: Couldn't release PPP unit: Invalid argument
Dec 31 16:31:54 alf pppd[31783]: Couldn't create new ppp unit: Inappropriate ioctl for device
Dec 31 16:31:54 alf pppd[27363]: Couldn't create new ppp unit: Inappropriate ioctl for device

Then the "Couldn't create new ppp unit" messages are repeated
very often until pppd is killed with SIGKILL (SIGHUP or SIGTERM
don't work).  Killing and restarting pppd seems to be the only
way to restore the connection, despite the pppd "persist" and
"maxfail 0" options.

I've tried to google for the "PPPIOCDETACH file->f_count=3"
message, and found that someone had this problem with PPPoE.
In my case, this is normal PPP over a serial port, which has
always been rock solid for me.

Please help - is this a known problem, which could be fixed
in recent 2.4.21-pre kernels?

Thanks,
Marek

