Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTHaPGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbTHaPGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:06:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4584 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261885AbTHaPGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:06:38 -0400
Date: Sun, 31 Aug 2003 17:06:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: create_proc_entry and !CONFIG_PROC_FS
Message-ID: <20030831150632.GU7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've observed a possible problem with create_proc_entry and 
!CONFIG_PROC_FS.

If !CONFIG_PROC_FS include/linux/proc_fs.h includes a dummy 
create_proc_entry that simply returns NULL.

Unfortunately, many callers of this function do things like e.g.

static int __init br2684_init(void)
{
        struct proc_dir_entry *p;
        if ((p = create_proc_entry("br2684", 0, atm_proc_root)) == NULL)
                return -ENOMEM;
        p->proc_fops = &br2684_proc_operations;
        br2684_ioctl_set(br2684_ioctl);
        return 0;
}


IOW, the dummy create_proc_entry fixes the compilation but the init 
function always returns -ENOMEM if !CONFIG_PROC_FS.

Is there any better solution than removing the dummy create_proc_entry 
and #ifdef'ing all places where it's used?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

