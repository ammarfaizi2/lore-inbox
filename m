Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131509AbRC0Tru>; Tue, 27 Mar 2001 14:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131513AbRC0Trk>; Tue, 27 Mar 2001 14:47:40 -0500
Received: from james.kalifornia.com ([208.179.59.2]:33890 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131509AbRC0Tr3>; Tue, 27 Mar 2001 14:47:29 -0500
Message-ID: <3AC0EE21.BD5CB144@blue-labs.org>
Date: Tue, 27 Mar 2001 11:46:42 -0800
From: David Ford <david@blue-labs.org>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Bug in reiserfs?  2.4.3-pre6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately I've been having to reboot every few days due to D state
processes, always mozilla so far.  When I exit mozilla it doesn't always
cleanly shutdown, sometimes processes are left behind.  I'll post what I
have and if I'm lucky I'll follow up with a backtrace on the pids.  Last
time I tried a sysrq-t, it killed X from under me.

# ps aux|grep mozi
david     6530  0.3  7.1 33444 18180 ?       D    11:34   0:00
/usr/src/mozilla/
david     6533  0.0  7.1 33444 18180 ?       D    11:34   0:00
/usr/src/mozilla/

# ps -eo pid,args,wchan|grep moz
 6530 /usr/src/mozilla down_write_failed
 6533 /usr/src/mozilla down_write_failed

 5 [kreclaimd]      kreclaimd
 6 [bdflush]        bdflush
18 [kreiserfsd]     reiserfs_journal_commit_thread


# ls -l /proc/6530/fd
total 0
lrwx------   1 david    users          64 Mar 27 11:42 0 -> /dev/vc/12
lrwx------   1 david    users          64 Mar 27 11:42 1 -> /dev/vc/12
lrwx------   1 david    users          64 Mar 27 11:42 2 -> /dev/vc/12
lrwx------   1 david    users          64 Mar 27 11:42 3 -> /dev/zero
lrwx------   1 david    users          64 Mar 27 11:42 4 ->
/usr/src/mozilla/component.reg
lr-x------   1 david    users          64 Mar 27 11:42 5 ->
pipe:[3377132]
l-wx------   1 david    users          64 Mar 27 11:42 6 ->
pipe:[3377132]
lr-x------   1 david    users          64 Mar 27 11:42 7 ->
/usr/src/mozilla/chrome/classic.jar
lrwx------   1 david    users          64 Mar 27 11:42 8 ->
socket:[3377145]
lr-x------   1 david    users          64 Mar 27 11:42 9 ->
/usr/src/mozilla/chrome/en-US.jar
lr-x------   1 david    users          64 Mar 27 11:42 10 ->
pipe:[3377180]
l-wx------   1 david    users          64 Mar 27 11:42 11 ->
pipe:[3377180]
lr-x------   1 david    users          64 Mar 27 11:42 12 ->
pipe:[3377181]
l-wx------   1 david    users          64 Mar 27 11:42 13 ->
pipe:[3377181]
lr-x------   1 david    users          64 Mar 27 11:42 14 ->
pipe:[3377298]
l-wx------   1 david    users          64 Mar 27 11:42 15 ->
pipe:[3377298]
lr-x------   1 david    users          64 Mar 27 11:42 16 ->
/usr/src/mozilla/chrome/comm.jar
lr-x------   1 david    users          64 Mar 27 11:42 17 ->
/usr/src/mozilla/chrome/toolkit.jar
lr-x------   1 david    users          64 Mar 27 11:42 18 ->
/usr/src/mozilla/chrome/messenger.jar
lr-x------   1 david    users          64 Mar 27 11:42 19 ->
/usr/src/mozilla/chrome/US.jar
lr-x------   1 david    users          64 Mar 27 11:42 20 ->
/usr/src/mozilla/chrome/en-unix.jar
lr-x------   1 david    users          64 Mar 27 11:42 21 ->
/usr/src/mozilla/chrome/chatzilla.jar

-d


--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



