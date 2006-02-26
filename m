Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWBZWzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWBZWzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWBZWzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:55:33 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:33484 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1751422AbWBZWzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:55:32 -0500
Date: Sun, 26 Feb 2006 23:55:25 +0100
To: linux-kernel@vger.kernel.org
Subject: o_sync in vfat driver
From: col-pepper@piments.com
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s5lranplj68xd1@mail.piments.com>
User-Agent: Opera M2/8.51 (Linux, build 1462)
X-Ovh-Remote: 213.103.54.253 (d213-103-54-253.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

part 3 (we'll get past these filters in the end...)

These devices do present special problems since they are a rw media that
can be abruptly removed at any time without even the chance for the OS to
interrupt on-going IO.

This is compounded by the fact that flash memory has to be zeroed and then
rewritten with the new data. If the device is physically removed before a
block is written the update will be lost. If it is removed _during_ write
the new and the old data will likely be lost.

If the block being written is the FAT , the principal record of the
structure of the whole disk will very likely be erased.

Since there is a heavy performance penalty involved (typically around an
_order of magnitude_ slower), it seems that the sole aim here is security
of data at any cost in the case of premature withdrawal.
