Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276490AbRI2Mtx>; Sat, 29 Sep 2001 08:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276491AbRI2Mtm>; Sat, 29 Sep 2001 08:49:42 -0400
Received: from dag.newtech.fi ([195.163.186.138]:19146 "HELO dag.newtech.fi")
	by vger.kernel.org with SMTP id <S276490AbRI2Mte> convert rfc822-to-8bit;
	Sat, 29 Sep 2001 08:49:34 -0400
Message-ID: <20010929125000.29614.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-0.27
To: linux-kernel@vger.kernel.org
Subject: Linediscipline behaviour
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sat, 29 Sep 2001 15:50:00 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Just checked out why my pppd hangs on exit
when the device is connected through USB
and found out that the reason was that the
code tried to change the linediscipline back
to what it was before ppd and that the ioctl()
hangs if the device doesn't exist any more as
the USB device has disappeared at that point.

Shouldn't the ioctl(TIOCSETD) return a ENODEV 
instead of hanging ?
The previous tcflush() does indeed do that and the
problem was then avoidable, but I think I just
fixed the symptoms, not the disease....

BRGDS


-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


