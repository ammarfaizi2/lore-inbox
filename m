Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272819AbTG3LX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272822AbTG3LX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:23:29 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:62099 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S272819AbTG3LXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:23:19 -0400
Date: Wed, 30 Jul 2003 13:23:17 +0200 (MET DST)
From: Pilaszy Istvan <pila@inf.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: bug in loopback device (Linux version 2.6.0-test2)
Message-ID: <Pine.GSO.4.00.10307301313200.21959-100000@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found a bug in the loopback device.
See this two different results (the difference: in the second case I use
`-o loop' mount option for mounting /dev/hda3 to /hda3_copy

First case:
mount -t reiserfs /dev/hda3 /hda3
mount -t reiserfs /dev/hda3 /hda3_copy
rm -f /hda3/* /hda3_copy/*
ls -l /hda3/ /hda3_copy/
touch /hda3/xxx /hda3_copy/yyy
echo
ls -l /hda3 /hda3_copy
umount /hda3
umount /hda3_copy

The result is:
/hda3/:
total 0

/hda3_copy/:
total 0

/hda3:
total 0
-rw-r--r--    1 root     root            0 Jul 30 13:15 xxx
-rw-r--r--    1 root     root            0 Jul 30 13:15 yyy

/hda3_copy:
total 0
-rw-r--r--    1 root     root            0 Jul 30 13:15 xxx
-rw-r--r--    1 root     root            0 Jul 30 13:15 yyy

Everything is OK.
-----------------------------------------------------------------------
Second case:

mount -t reiserfs /dev/hda3 /hda3
mount -o loop -t reiserfs /dev/hda3 /hda3_copy
rm -f /hda3/* /hda3_copy/*
ls -l /hda3/ /hda3_copy/
touch /hda3/xxx /hda3_copy/yyy
echo
ls -l /hda3 /hda3_copy
umount /hda3
umount /hda3_copy

And the result:
/hda3/:
total 0

/hda3_copy/:
total 0

/hda3:
total 0
-rw-r--r--    1 root     root            0 Jul 30 13:17 xxx

/hda3_copy:
total 0
-rw-r--r--    1 root     root            0 Jul 30 13:17 yyy
---------------------------------------------------------------------------
Its quite interesting :-) Why to store to copy of the directory in the
memory? It causes inconsistency, and wastes memory.

Bye,
Istvan


