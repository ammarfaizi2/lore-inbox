Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTDED5G (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 22:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTDED5G (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 22:57:06 -0500
Received: from x101-201-233-dhcp.reshalls.umn.edu ([128.101.201.233]:24735
	"EHLO minerva") by vger.kernel.org with ESMTP id S261764AbTDED5F (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 22:57:05 -0500
Date: Fri, 4 Apr 2003 22:08:36 -0600
From: Matt Reppert <arashi@yomerashi.yi.org>
To: Richard Henderson <rth@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.66-bk build failure on LX164
Message-Id: <20030404220836.2c3f3467.arashi@yomerashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Configured for an EV56 LX164 machine, build fails in kernel/sys.c for me:

kernel/sys.c:226: conflicting types for `sys_sendmsg'
include/linux/socket.h:245: previous declaration of `sys_sendmsg'
kernel/sys.c:227: conflicting types for `sys_recvmsg'
include/linux/socket.h:246: previous declaration of `sys_recvmsg'

The sys.c declaration is "cond_syscall (sys_sendmsg)", which expands to
asmlinkage long sys_sendmsg(void) __attribute__((weak,alias("sys_ni_syscall")));
using the definition of cond_syscall in include/asm-alpha/unistd.h.
In socket.h, we have asmlinkage
"long sys_sendmsg(int fd, struct msghdr *msg, unsigned flags)"

Matt
