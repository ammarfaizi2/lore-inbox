Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbUKQUsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUKQUsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbUKQUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:48:26 -0500
Received: from sv1.lisha.ufsc.br ([150.162.62.1]:55256 "EHLO sv1.lisha.ufsc.br")
	by vger.kernel.org with ESMTP id S262521AbUKQUnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:43:51 -0500
From: Thiago Robert dos Santos <robert@lisha.ufsc.br>
Message-ID: <32825.150.162.62.34.1100724226.squirrel@150.162.62.34>
Date: Wed, 17 Nov 2004 18:43:46 -0200 (BRDT)
Subject: remap_page_range
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-0.f1.1
X-Mailer: SquirrelMail/1.4.3a-0.f1.1
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041117184346_17885"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041117184346_17885
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

All,

  I'm having a problem with remap_page_range in the 2.6 kernel series. I
use remap_page_range inside the mmap function of a module I wrote in
order to map a given device's memory into user space.

  Apparently, everything works fine but I just can't access the device's
memory (even tough I get a valid point from the mmap system call). This
is the mmap function I wrote:


static int
pcimap_mmap (struct file *filp, struct vm_area_struct *vma)
{

    int unit, reg;
    unsigned long size, phy_addr;

    unit = MINOR(filp->f_dentry->d_inode->i_rdev) >> 4;
    reg = MINOR(filp->f_dentry->d_inode->i_rdev) & 0x0f;

    size = vma->vm_end - vma->vm_start;

    /* Mapping must be page aligned and not larger than the region size */
    if ((size + vma->vm_pgoff * PAGE_SIZE) > pcidevs[unit].reg[reg].size)
    {
        return -EINVAL;
    }

    /* Get device's memory physical address for mapping */
    phy_addr = pcidevs[unit].reg[reg].phy_addr + vma->vm_pgoff * PAGE_SIZE;

    /* Map device's memory in the requested address space range */
    if (remap_page_range (vma, phy_addr, 0, size, vma->vm_page_prot))
    {
        return -EAGAIN;
    }

    filp->f_dentry->d_inode->i_count.counter++;

    return 0;
}



    Can anyone help me?


Thanks in advance.


Thiago Robert
------=_20041117184346_17885
Content-Type: text/x-csrc; name="pcimap.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap.c"


------=_20041117184346_17885
Content-Type: text/x-chdr; name="pcimap.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap.h"


------=_20041117184346_17885
Content-Type: text/x-chdr; name="debug.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="debug.h"


------=_20041117184346_17885
Content-Type: application/octet-stream; name="Makefile"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Makefile"


------=_20041117184346_17885
Content-Type: text/x-csrc; name="pcimap_test.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap_test.c"


------=_20041117184346_17885--

