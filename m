Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUHDXkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUHDXkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267512AbUHDXid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:38:33 -0400
Received: from web53801.mail.yahoo.com ([206.190.36.196]:12926 "HELO
	web53801.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267518AbUHDXhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:37:32 -0400
Message-ID: <20040804233730.84600.qmail@web53801.mail.yahoo.com>
Date: Wed, 4 Aug 2004 16:37:30 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: Interesting failures of 'cscope'
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous posting related to false negatives obtained by 'cscope'. This posting relates
to false positives from the same cause (can't parse pointer-to-function declarations):

>From arch/i386/kernel/irq.c:

    621 int request_irq(unsigned int irq,
    622                 irqreturn_t (*handler)(int, void *, struct pt_regs *),
    623                 unsigned long irqflags,
    624                 const char * devname,
    625                 void *dev_id)

$ /usr/bin/cscope -d -p9 -L -3 setup_irq
...
arch/i386/kernel/irq.c irqreturn_t 660 retval = setup_irq(irq, action);
...

There is obviously no function called 'irqreturn_t'.
