Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSICJTs>; Tue, 3 Sep 2002 05:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSICJTs>; Tue, 3 Sep 2002 05:19:48 -0400
Received: from vitelus.com ([64.81.243.207]:6151 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S318742AbSICJTr>;
	Tue, 3 Sep 2002 05:19:47 -0400
Date: Tue, 3 Sep 2002 02:24:19 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 throughput woes on certain (possibly heavily fragmented) files
Message-ID: <20020903092419.GA5643@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This pretty much sums it up:

[aaronl@vitelus:~]$ time cat mail/debian-legal > /dev/null
cat mail/debian-legal > /dev/null  0.00s user 0.02s system 0% cpu 5.565 total
[aaronl@vitelus:~]$ ls -l mail/debian-legal
-rw-------    1 aaronl   mail      7893525 Sep  3 00:42 mail/debian-legal
[aaronl@vitelus:~]$ time cat /usr/src/linux-2.4.18.tar.bz2 > /dev/null
cat /usr/src/linux-2.4.18.tar.bz2 > /dev/null  0.00s user 0.10s system 16% cpu 0.616 total
[aaronl@vitelus:~]$ ls -l /usr/src/linux-2.4.18.tar.bz2 
-rw-r--r--    1 aaronl   aaronl   24161675 Apr 14 11:53

Both files were AFAIK not in any cache, and they are on the same
partition.

My current uninformed theory is that this is caused by fragmentation,
since the linux tarball was downloaded all at once but the mailbox I'm
comparing it to has 1695 messages, each of which having been appended
seperately to the file. All of my mailboxes exhibit similarly awful
performance.

Do any other filesystems handle this type of thing more gracefully? Is
there room for improvement in ext3? Is there any way I can test my
theory by seeing how fragmented a certain inode is? What can I do to
avoid extensive fragmentation, if it is truely the cause of my issue?

I'm running 2.4.20-pre5, but this is not a recently-introduced problem.

The disk is IDE - nothing fancy, WDC WD200BB-18CAA0. IDE controller is
ServerWorks CSB5. However, I've had this problem consistantly on
previous hardware.
