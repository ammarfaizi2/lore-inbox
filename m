Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSG2NhJ>; Mon, 29 Jul 2002 09:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSG2NhJ>; Mon, 29 Jul 2002 09:37:09 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36508 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317194AbSG2NhI>;
	Mon, 29 Jul 2002 09:37:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Jul 2002 15:39:52 +0200 (MEST)
Message-Id: <UTC200207291339.g6TDdqf18529.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Subject: bug in the present partition code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

A BUG_ON at device.h:215 is triggered by
scsi_unregister_host -> sd_detach -> driverfs_remove_partitions ->
device_remove _file
because driverfs_remove_partitions is called for a device
where driverfs_create_partitions was not called for.

(A device without media - no partitions have ever been seen.)

There are various ways to fix - I'll leave it to you to pick
some appropriate one.

Andries


[I find that code becomes ugly when one includes a struct in
another struct. Lots of assignments
	ptr = &(p->start_of_struct);
The advantage of having things separate is that one can use
NULL to mean "uninitialized", while &(p->start_of_struct)
is never NULL. So, I wouldn't mind adding a * and an r in the
   struct device hd_driverfs_dev;  /* support driverfs hiearchy */
in struct hd_struct. But you may have other preferences.]
