Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbTFXPG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTFXPGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:06:55 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:5385 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265538AbTFXPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:06:55 -0400
Date: Tue, 24 Jun 2003 19:20:25 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?iso-8859-1?Q?Przemyslaw_Stanis=B3aw_Knycz?= <zolw@wombb.edu.pl>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: linux-2.5.73 at alpha compile error
Message-ID: <20030624192024.A14606@jurassic.park.msu.ru>
References: <20030624160435.71b24c05.zolw@wombb.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030624160435.71b24c05.zolw@wombb.edu.pl>; from zolw@wombb.edu.pl on Tue, Jun 24, 2003 at 04:04:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 04:04:35PM +0200, Przemyslaw Stanis³aw Knycz wrote:
> arch/alpha/kernel/built-in.o(.data+0x2260): undefined reference to
> `sys_socket'

Same problem with CONFIG_NET=n on sparc32/64, mips32/64, parisc and ia64.
sys_socket should be a cond_syscall.

Ivan.

--- 2.5/kernel/sys.c	Tue Jun 17 08:19:40 2003
+++ linux/kernel/sys.c	Tue Jun 24 18:24:58 2003
@@ -220,6 +220,7 @@ cond_syscall(sys_sendto)
 cond_syscall(sys_send)
 cond_syscall(sys_recvfrom)
 cond_syscall(sys_recv)
+cond_syscall(sys_socket)
 cond_syscall(sys_setsockopt)
 cond_syscall(sys_getsockopt)
 cond_syscall(sys_shutdown)
