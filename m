Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbSJAQn6>; Tue, 1 Oct 2002 12:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbSJAQn5>; Tue, 1 Oct 2002 12:43:57 -0400
Received: from crack.them.org ([65.125.64.184]:15123 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262159AbSJAQnS>;
	Tue, 1 Oct 2002 12:43:18 -0400
Date: Tue, 1 Oct 2002 12:49:07 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Capabilities-related change in 2.5.40
Message-ID: <20021001164907.GA25307@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I think the LSM code is confused in its use of cap_t.  I think
that cap_capget should be using to_cap_t instead; it's converting _to_ a
kernel_cap_t, right?



Second of all, my login shell (as a user) gets a very bizarre response to sys_capget:

capget(0x19980330, 0, {CAP_CHOWN | CAP_DAC_OVERRIDE | CAP_DAC_READ_SEARCH |
  CAP_FOWNER | CAP_FSETID | CAP_KILL | CAP_SETGID | CAP_SETUID |
  CAP_LINUX_IMMUTABLE | CAP_NET_BIND_SERVICE | CAP_NET_BROADCAST |
  CAP_NET_ADMIN | CAP_NET_RAW | CAP_IPC_LOCK | CAP_IPC_OWNER | CAP_SYS_MODULE
  | CAP_SYS_RAWIO | CAP_SYS_CHROOT | CAP_SYS_PTRACE | CAP_SYS_PACCT |
  CAP_SYS_ADMIN | CAP_SYS_BOOT | CAP_SYS_NICE | CAP_SYS_RESOURCE |
  CAP_SYS_TIME | CAP_SYS_TTY_CONFIG | 0xf8000000,
  CAP_CHOWN | CAP_DAC_OVERRIDE
  | CAP_DAC_READ_SEARCH | CAP_FOWNER | CAP_FSETID | CAP_KILL | CAP_SETGID |
  CAP_SETUID | CAP_SETPCAP | CAP_LINUX_IMMUTABLE | CAP_NET_BIND_SERVICE |
  CAP_NET_BROADCAST | CAP_NET_ADMIN | CAP_NET_RAW | CAP_IPC_LOCK |
  CAP_IPC_OWNER | CAP_SYS_MODULE | CAP_SYS_RAWIO | CAP_SYS_CHROOT |
  CAP_SYS_PTRACE | CAP_SYS_PACCT | CAP_SYS_ADMIN | CAP_SYS_BOOT | CAP_SYS_NICE
  | CAP_SYS_RESOURCE | CAP_SYS_TIME | CAP_SYS_TTY_CONFIG | 0xf8000000,}) = 0

The reason?  cap_get_proc has always been broken.  But the capability set of
task 0, swapper, has now changed.  It used to be empty.  So, I'll go report
this to libcap.  The change in capabilities for swapper is presumably
benign.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
