Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269909AbRHTXxx>; Mon, 20 Aug 2001 19:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269918AbRHTXxm>; Mon, 20 Aug 2001 19:53:42 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:62857 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269909AbRHTXxj>; Mon, 20 Aug 2001 19:53:39 -0400
Date: Mon, 20 Aug 2001 16:53:53 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Steve.Ralston@lsil.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.9/drivers/block/genhd.c eliminating unnecessary fusion_init call
Message-ID: <20010820165353.A14554@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.4.9/drivers/block/genhd.c calls fusion_init, but
fusion_init is again called unconditionally due to the
module_init() call at the end of drivers/message/fusion/mptbase.c.
The only effect of the second call is to possibly generate a printk,
since the fusion driver has code to protect against this case.  However,
the fusion driver also has code that automatically calls fusion_init
if mpt_register is called before fusion_init, so there does not
seem to be a need to an early call in drivers/block/genhd.c.

	So, the following patch removes the unnecessary call
from genhd.c.  I believe no changes to the fusion driver or
the initialization order in linux/Makefile are necessary.

	By the way, this is a fake patch.  The kernel that I am
actually using has no drivers/block/genhd.c anymore, since I
have eliminating all of its calls.

	Steven: could you please comment on this patch?  If you
see no problems with it, I would like to ask Alan and Linus to
integrate it into their kernels (or you can do so, or we can
follow whatever procedure you prefer).  Please let me know.
Thanks in advance.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
