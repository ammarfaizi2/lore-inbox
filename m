Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSLaQLF>; Tue, 31 Dec 2002 11:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSLaQLF>; Tue, 31 Dec 2002 11:11:05 -0500
Received: from cs.huji.ac.il ([132.65.16.30]:59911 "EHLO cs.huji.ac.il")
	by vger.kernel.org with ESMTP id <S263794AbSLaQLA>;
	Tue, 31 Dec 2002 11:11:00 -0500
Date: Tue, 31 Dec 2002 18:19:24 +0200 (IST)
From: Amar Lior <lior@cs.huji.ac.il>
To: linux-kernel@vger.kernel.org
cc: Amar Lior <lior@cs.huji.ac.il>
Subject: Problem
Message-ID: <Pine.LNX.4.20_heb2.08.0212311818280.29471-100000@mos214.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I found a bug that cause the kernel to lockup.

The problem is in mm/shmem.c do_shmem_file_read() (the tmpfs)

at line 959 there is a call to file_read_actor(desc, page, offset, nr);

The problem is that inside the function file_read_actor() desc->error is
set to -EFAULT (this happens when the buffer supplied by the user for the 
read is wrong)
but there is no check right after the return from file_read_actor() to
test this situation.

The result is that the desc->count field always stay the same and the
while loop in do_shmem_file_read never end and the kernel locksup.

The fix is very simple just add the following line after the call to 
file_read_actor():

-------------------
if(desc->error)
        break
-------------------

If you need any other info please mail me

Regards

--lior


________________________________________________________________   
Lior Amar                       Distributed Computing Lab MOSIX
E-mail  : lior@cs.huji.ac.il                           
________________________________________________________________   

