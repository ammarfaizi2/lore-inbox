Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTJGUfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTJGUfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:35:19 -0400
Received: from [207.175.35.50] ([207.175.35.50]:7838 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S262771AbTJGUfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:35:12 -0400
Message-ID: <3F83231D.1080905@eternal-systems.com>
Date: Tue, 07 Oct 2003 13:33:33 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: calling devinet_ioctl from a kernel module
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org> <3F7F1D21.1070503@nodomain.org> <20031004205545.GB71123@colin2.muc.de> <3F7F4AFC.7000700@nodomain.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm experiencing a kernel panic in RedHat Linux 8.0 with 2.4.20 kernel 
when calling the function devinet_ioctl() with the SIOCSIFADDR command 
from within a kernel module.  The function is called within the scope of
userspace addressing in the following manner.

int res;
mm_segment_t oldfs = get_fs();
set_fs(get_ds());
res = devinet_ioctl(cmd,arg);
set_fs(oldfs);

This is how ipconfig.c illustrates how to use this function from within 
a kernel module, see ic_dev_ioctl() function in the source file.

When running in the scope of a kgdb patched kernel, I see the kernel 
panic when this function is called from within my kernel module. The 
panic happens because alloc_skb is being called non-atomically from an 
interrupt.

Is there anything grossly wrong that I am doing? Am I supposed to do 
something else before calling this function?

Thanks,
Vishwas.

