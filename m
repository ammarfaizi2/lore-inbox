Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261828AbSJDOcq>; Fri, 4 Oct 2002 10:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSJDOcq>; Fri, 4 Oct 2002 10:32:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22168 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261828AbSJDOcg>;
	Fri, 4 Oct 2002 10:32:36 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 3/4: evms_ioctl.h
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.ne
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF3A568674.694920EA-ON85256C48.004FE459@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Fri, 4 Oct 2002 09:44:16 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/04/2002 10:38:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2002 at 6:49 PM, Andi Kleen wrote:
> I think you have some security holes in there:

 > +parms.buffer_address  = (u8 *)uvirt_to_kernel(parms32.buffer_address);
 > [...]
 > +set_fs(KERNEL_DS);
 > +rc = sys_ioctl(fd, kcmd, (unsigned long)karg);
 > +set_fs(old_fs);


> parms32.buffer_address comes from user space. With the set_fs you turn
> off all access checking. Surely when whatever sits at the bottom of
> sys_ioctl accesses it it'll use copy_from/to_user and it will do an
> unchecked reference of a user supplied pointer, allowing it to read/write
> all memory.

> Same bug is present in more functions.

> The rule is: when you do set_fs(KERNEL_DS) you have to copy all user
supplied
> pointers before it.

Yes, we became aware of this while working on sparc64 and have
coded the appropriate copy *before* set_fs(KERNEL_DS).
Unfortunately, that code didn't make it into CVS yet.
This will be fixed ASAP.

Thanks for pointing it out.
Mark


