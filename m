Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVATSEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVATSEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVATSEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:04:42 -0500
Received: from innocence-lost.us ([66.93.152.112]:43449 "EHLO
	innocence-lost.net") by vger.kernel.org with ESMTP id S261413AbVATSC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:02:26 -0500
Date: Thu, 20 Jan 2005 11:02:26 -0700 (MST)
From: jnf <jnf@innocence-lost.us>
To: linux-kernel@vger.kernel.org
Subject: linux capabilities ?
Message-ID: <Pine.LNX.4.61.0501201053070.24484@fhozvffvba.vaabprapr-ybfg.arg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have been playing a little here and there with linux capabilities, and
seem to be hitting a few snags so I was hoping to obtain some input on
their current status. The kernel on the box in question is 2.6.10, with
the CAP_INIT_EFF_SET macro modified to allow init to have CAP_SETPCAP.

I am mostly trying to accomplish this so that I can run syslog as a
non-root user and as I understand it by digging through the source, one
should be able to accomplish this with the CAP_SYS_ADMIN capability-
however this does not appear to be true ?

in kernel/printk.c I see

error = security_syslog(type)
if (error)
        return error ;

which is defined in something like include/linux/security.h as a pointer
to cap_syslog(), which in turn is defined in security/commoncap.c where I
see:

if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
         return -EPERM
return 0;


Type 3 is:
*      3 -- Read up to the last 4k of messages in the ring buffer.

So when I give the process CAP_SYS_ADMIN I still cannot seem to read from
/proc/kmsg, I also tried giving it CAP_DAC_OVERRIDE just to test to see if
DAC's were the problem but that didn't seem to help any.

So with that said, anyone have any idea's as to what I need to do and any
details on the current state of the capabilities would be helpful.

Thanks,

jnf


