Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262438AbTCROk3>; Tue, 18 Mar 2003 09:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbTCROk3>; Tue, 18 Mar 2003 09:40:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64587 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262438AbTCROkN>; Tue, 18 Mar 2003 09:40:13 -0500
Date: Tue, 18 Mar 2003 09:51:08 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: BOEBLINGEN LINUX390 <LINUX390@de.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [s390x] Patch for execve with a mode switch
Message-ID: <20030318095108.A17230@devserv.devel.redhat.com>
References: <OFA75E38A6.F16CA542-ONC1256CED.00308E93@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFA75E38A6.F16CA542-ONC1256CED.00308E93@de.ibm.com>; from LINUX390@de.ibm.com on Tue, Mar 18, 2003 at 09:57:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "BOEBLINGEN LINUX390" <LINUX390@de.ibm.com>
> Date: Tue, 18 Mar 2003 09:57:47 +0100

> I am not too happy with the arch_get_unmapped_area myself. I not
> happpy with the TIF_ABI_PENDING bit either, there has to be a
> way to do this in a simply and straighforward way.
> I'll keep thinking about it.

Actually, I agree, but the only way out that I see is to
add yet another macro, which replaces the second SET_PERSONALITY
on 2.5 and adds a hook for 2.4 in that place.

Current 2.5 code looks bizzare:

    for (headers) {
        if (is header) {
            interpreter = x;
            SET_PERSONALITY(elf_ex, ibcs2_interpreter);
            break;
        }
    }
    if (interpreter) {
    } else {
        SET_PERSONALITY(elf_ex, ibcs2_interpreter);
    }
    flush_old_exec();
    some_more_core
    SET_PERSONALITY(elf_ex, ibcs2_interpreter);	// Cries for extermination!
    current->mm->free_area_cache = TASK_UNMAPPED_BASE;

Spaghetti wihout goto's!! There's no way to get to the third
SET_PERSONALITY without being there once, so what does that mean?

-- Pete
