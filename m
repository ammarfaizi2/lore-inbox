Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264241AbTCXOiO>; Mon, 24 Mar 2003 09:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264243AbTCXOiM>; Mon, 24 Mar 2003 09:38:12 -0500
Received: from rebecca.tiscali.nl ([195.241.76.181]:32650 "EHLO
	rebecca.tiscali.nl") by vger.kernel.org with ESMTP
	id <S264241AbTCXOiJ>; Mon, 24 Mar 2003 09:38:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Frans Pop <aragorn@tiscali.nl>
To: linux-kernel@vger.kernel.org
Subject: Tape operation: missing filemark
Date: Mon, 24 Mar 2003 15:49:16 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030324144916.B7A214553A4@rebecca.tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on a bug in a 'tar cf /dev/tape --verify' operation.
This results in an error 'Unexpected EOF in archive' during the verify
stage of the operation and any subsequent attempts to read the archive from
tape.

The cause of this error is that no filemark is written between writing the
tape and the start of the verification.

My question.
Which should be responsible for writing a filemark in this situation: the
tape driver or tar?

When a 'normal' backup using tar (without verify option) is made, the tape
driver writes the filemark when a release request is received while the
driver is in write mode.
So my thinking is that the driver should also write a filemark when an
ioctl request is received while the driver is in write mode. Is this
correct?
Any pointers to documentation?

tar sends (roughly) the following sequence of requests to the driver:
- open device
- write data
- ioctl MTFSB 1 (space backwards 1 filemark)
- read data
- release device

I have debugged this problem using the ide-tape driver, but I have also
seen a bug report for the same problem from someone using a scsi tape
device.

I am using kernel 2.4.21-pre4 with Debian 3.0r1 (Woody) on i686.
tar is (GNU tar) 1.13.25.

Frans Pop
