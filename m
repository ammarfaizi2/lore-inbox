Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131881AbQKQKyH>; Fri, 17 Nov 2000 05:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131919AbQKQKxs>; Fri, 17 Nov 2000 05:53:48 -0500
Received: from astrid2.nic.fr ([192.134.4.2]:34052 "EHLO astrid2.nic.fr")
	by vger.kernel.org with ESMTP id <S131881AbQKQKxh>;
	Fri, 17 Nov 2000 05:53:37 -0500
Date: Fri, 17 Nov 2000 11:23:33 +0000
From: Francois romieu <romieu@ensta.fr>
To: Dan Aloni <karrde@callisto.yi.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
Message-ID: <20001117112333.D839@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
In-Reply-To: <Pine.LNX.4.21.0011162320230.17038-100000@callisto.yi.org> <Pine.LNX.4.21.0011171015270.19287-100000@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011171015270.19287-100000@callisto.yi.org>; from karrde@callisto.yi.org on Fri, Nov 17, 2000 at 10:37:39AM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU A: assume de->count = 1 (in de_put)
fs/proc/inode.c::44 if (!--de->count) {
de->count = 0

CPU B: (in remove_proc_entry)
fs/proc/generic.c::577         if (!de->count)
fs/proc/generic.c::578             free_proc_entry(de);

CPU A: (in de_put)
fs/proc/inode.c::45 if (de->deleted) { <-- dereferencing kfreed pointer

What does protect us from the preceding if lock_kernel is thrown ?

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
