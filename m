Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbVLWGQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbVLWGQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 01:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVLWGP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 01:15:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43163 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751223AbVLWGP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 01:15:59 -0500
Date: Fri, 23 Dec 2005 06:15:56 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [WTF?] sys_tas() on m32r
Message-ID: <20051223061556.GR27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asmlinkage int sys_tas(int *addr)
{
        int oldval;
        unsigned long flags;

        if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
                return -EFAULT;
        local_irq_save(flags);
        oldval = *addr;
        if (!oldval)
                *addr = 1;
        local_irq_restore(flags);
        return oldval;
}
in arch/m32r/kernel/sys_m32r.c.  Trivial oops *AND* ability to trigger
IO with interrupts disabled.
