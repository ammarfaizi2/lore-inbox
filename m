Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTCQPLZ>; Mon, 17 Mar 2003 10:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbTCQPLZ>; Mon, 17 Mar 2003 10:11:25 -0500
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:35067 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261732AbTCQPLY>; Mon, 17 Mar 2003 10:11:24 -0500
From: "BOEBLINGEN LINUX390" <LINUX390@de.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: [s390x] Patch for execve with a mode switch
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF4DCC5C2B.C044EACC-ONC1256CEC.004CE000@de.ibm.com>
Date: Mon, 17 Mar 2003 16:20:37 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 17/03/2003 16:21:59
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,
> If I boot an s390x kernel over a 31 bit userland, /sbin/init segfaults
> in the dynamic linker. This happens because mm->free_area_cache
> is set with TASK_UNMAPPED_BASE macro, which needs the TIF_31BIT
> set right. Setting TIF_31BIT in ELF_PLAT_INIT is way too late
> for this.
mm->free_area_cache can't cause any problems on s390x because it isn't
used. The idea behind mm->free_area_cache is to speed up the search in
get_unmapped_area/arch_get_unmapped_area. But s390x defines its own
version of arch_get_unmapped_area in arch/s390x/kernel/sys_s390.c
which doesn't start the search at mm->free_area_cache.

> The patch below basically ports what sparc64 does to s390x,
> according to the Andrew Morton's comment in fs/binfmt_elf.c.
> To tell the truth, I actually use equivalent of this on 2.4,
> but I think it's important to get stock 2.5 right.
This patch is severly broken. It wouldn't even compile.

To make sure I retested the kernel 2.5.64 with the patches I sent to
this list and ipled a 31 bit userland successfully.

blue skies,
  Martin.


