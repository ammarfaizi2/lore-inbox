Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUALCS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUALCRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:17:46 -0500
Received: from law11-f33.law11.hotmail.com ([64.4.17.33]:14853 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266028AbUALCRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:17:42 -0500
X-Originating-IP: [128.105.166.148]
X-Originating-Email: [muthian_s@hotmail.com]
From: "Muthian S" <muthian_s@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: ext2 ordering/timing of writes
Date: Mon, 12 Jan 2004 02:17:41 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F33nwoYnFKwdG0002ba50@hotmail.com>
X-OriginalArrivalTime: 12 Jan 2004 02:17:41.0811 (UTC) FILETIME=[41E99030:01C3D8B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I understand that ext2 provides very little guarantees on the ordering or 
timing of metadata and data writes.  Could someone please confirm that the 
following sequence of events can indeed happen in practice ?  The sequence 
does not lead to any specific integrity or consistency concern, but is an 
issue for something I am working on.

1. Block B1 allocated to inode I1
2. Inode block containing I1 written to disk
3. B1 freed from I1 (partial truncate of file)
4. B1 assigned to new inode I2
5. B1 written to disk in the context of I2
6. I2 deleted, freeing B1
7. B1 again assigned to I1
8. Inode block containing I1 written to disk
9. Inode block containing I2 written to disk

If there is any ordering policy that would preclude this sequence in ext2, 
please  let me know.
I know that ext3 provides special ordering that would prevent reuse of a 
block before the delete reaches disk, but is there something similar in ext2 
?

thanks a lot!
Muthian.

_________________________________________________________________
Free transactions in any ATM across India. 
http://server1.msn.co.in/msnleads/suvidha/dec03.asp?type=hottag Click here.

