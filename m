Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319148AbSIJOpy>; Tue, 10 Sep 2002 10:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319153AbSIJOpy>; Tue, 10 Sep 2002 10:45:54 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:39851 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S319148AbSIJOpw>; Tue, 10 Sep 2002 10:45:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: fsync trouble with 2.5.34
Date: Tue, 10 Sep 2002 16:50:31 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209101650.31302.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.5.34 (gcc version 3.2.1), 400MHz AMD K6-2, UP, preemptible.

kmail 1.4.3 keeps hanging for several (sometimes many) seconds when
running 2.5.34.  I attached gdb to it during one of these hangs and got

(gdb) bt
#0  0x411544fd in fsync () from /lib/libc.so.6
#1  0x410119c6 in fsync () from /lib/libpthread.so.0
#2  0x0812ee88 in KDialog::marginHint ()
#3  0x08107948 in KDialog::marginHint ()
#4  0x0814734c in KDialog::marginHint ()
#5  0x08149089 in KDialog::marginHint ()
#6  0x0814306e in KDialog::marginHint ()
#7  0x40b71b26 in QObject::activate_signal () from /usr/lib/libqt-mt.so.3
#8  0x403baec3 in KIO::Job::result () from /usr/lib/libkio.so.4
#9  0x403ac8f8 in KIO::Job::emitResult () from /usr/lib/libkio.so.4
#10 0x403ad875 in KIO::SimpleJob::slotFinished () from /usr/lib/libkio.so.4
#11 0x403aecb5 in KIO::TransferJob::slotFinished () from /usr/lib/libkio.so.4
#12 0x403bc13c in KIO::TransferJob::qt_invoke () from /usr/lib/libkio.so.4
#13 0x40b71b26 in QObject::activate_signal () from /usr/lib/libqt-mt.so.3
#14 0x40b71a7e in QObject::activate_signal () from /usr/lib/libqt-mt.so.3
#15 0x403a570c in KIO::SlaveInterface::finished () from /usr/lib/libkio.so.4
#16 0x403a42a4 in KIO::SlaveInterface::dispatch () from /usr/lib/libkio.so.4
#17 0x403a3df8 in KIO::SlaveInterface::dispatch () from /usr/lib/libkio.so.4
#18 0x403a2010 in KIO::Slave::gotInput () from /usr/lib/libkio.so.4
#19 0x403a3809 in KIO::Slave::qt_invoke () from /usr/lib/libkio.so.4
#20 0x40b71b26 in QObject::activate_signal () from /usr/lib/libqt-mt.so.3
#21 0x40b71c34 in QObject::activate_signal () from /usr/lib/libqt-mt.so.3
#22 0x40dad40b in QSocketNotifier::activated () from /usr/lib/libqt-mt.so.3
#23 0x40b87a4c in QSocketNotifier::event () from /usr/lib/libqt-mt.so.3
#24 0x40b2a773 in QApplication::internalNotify () from /usr/lib/libqt-mt.so.3

I was doing some heavy compiling at the same time.

Looks like a kernel bug / behaviour change.

All the best,

Duncan.
