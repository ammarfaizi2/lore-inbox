Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbQKQMME>; Fri, 17 Nov 2000 07:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132128AbQKQMLo>; Fri, 17 Nov 2000 07:11:44 -0500
Received: from [213.8.185.152] ([213.8.185.152]:52497 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S132101AbQKQMLh>;
	Fri, 17 Nov 2000 07:11:37 -0500
Date: Fri, 17 Nov 2000 13:40:58 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Francois romieu <romieu@ensta.fr>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
In-Reply-To: <20001117112333.D839@nic.fr>
Message-ID: <Pine.LNX.4.21.0011171332240.3199-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Francois romieu wrote:

> CPU A: assume de->count = 1 (in de_put)
> fs/proc/inode.c::44 if (!--de->count) {
> de->count = 0
> 
> CPU B: (in remove_proc_entry)
> fs/proc/generic.c::577         if (!de->count)
> fs/proc/generic.c::578             free_proc_entry(de);
> 
> CPU A: (in de_put)
> fs/proc/inode.c::45 if (de->deleted) { <-- dereferencing kfreed pointer
> 
> What does protect us from the preceding if lock_kernel is thrown ?
 
Ok, anyway, notice that in line 41 we return from de_put() without 
unlock_kernel()'ing the kernel. It doesn't look good.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
