Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266531AbRGLTym>; Thu, 12 Jul 2001 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266534AbRGLTyd>; Thu, 12 Jul 2001 15:54:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29963 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266531AbRGLTyV>; Thu, 12 Jul 2001 15:54:21 -0400
Subject: Re: [PATCH] ACP Modem (Mwave)
To: paulsch@us.ibm.com (Paul Schroeder)
Date: Thu, 12 Jul 2001 20:55:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, sullivam@us.ibm.com (Mike Sullivan),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <OF080C19B9.CE6E4B6A-ON85256A86.00799C20@raleigh.ibm.com> from "Paul Schroeder" at Jul 11, 2001 05:11:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15KmY8-0006iS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch has been updated...  The updates primarily consist of Alan's
> suggested changes below... (thank you)  It applies against the 2.4.6
> kernel...

A quick glance through it:

dsp3780I_WriteDStore still touches user space with a spinlock held
(also doesnt check the get_user return)

The ioctl handlers do not check copy_from_user/to_user returns

IOCTL_MW_UNREGISTER_IPC will oops if fed bogus info (ipcnum should be
unsigned)

The return should be -ENOTTY not -ENOIOCTLCMD  unless its internal code
that catches NOIOCTLCMD and changes it before user space sees it

mwave_Read should be -EINVAL not -ENOSYS (ENOSYS means the entire read syscall
in the OS isnt there)

In debug mode mwave_write accesses user space directly and may crash
(buf[0])

Trivial item - coding style uses foo(void) not foo() to indicate functions
taking no arguments

Still have globals like "dspio" "uartio"  "ClaimResources" etc

whats wrong with tp3780_uart_io etc for globals ?

Otherwise it looks close to ready

Alan

