Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUIGMXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUIGMXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267977AbUIGMXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:23:05 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:51094 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267973AbUIGMWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:22:21 -0400
Date: Tue, 7 Sep 2004 14:21:59 +0200 (CEST)
From: Simon Derr <simon.derr@bull.net>
X-X-Sender: derr@daphne.frec.bull.fr
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0409071415380.10577@daphne.frec.bull.fr>
References: <20040907020831.62390588.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> add-some-key-management-specific-error-codes.patch
>   Add some key management specific error codes
>
> keys-new-error-codes-for-alpha-mips-pa-risc-sparc-sparc64.patch
>   keys: new error codes for Alpha, MIPS, PA-RISC, Sparc & Sparc64
>
> implement-in-kernel-keys-keyring-management.patch
>   implement in-kernel keys & keyring management
>   keys build fix
>   keys & keyring management update patch
>   implement-in-kernel-keys-keyring-management-update-build-fix
>   implement-in-kernel-keys-keyring-management-update-build-fix-2
>   key management patch cleanup
>
> make-key-management-code-use-new-the-error-codes.patch
>   Make key management code use new the error codes
>
> keys-permission-fix.patch
>   keys: permission fix
>
> keys-keyring-management-keyfs-patch.patch
>   keys & keyring management: keyfs patch
>
> keyfs-build-fix.patch
>   keyfs build fix

Build fails without CONFIG_KEYS:

kernel/sys.c:283:29: macro "sys_request_key" requires 5 arguments, but only 1 given
kernel/sys.c:283: error: `sys_request_key' defined both normally and as an alias
kernel/sys.c:283: warning: `syscall_linkage' attribute only applies to function types
kernel/sys.c:284:24: macro "sys_keyctl" requires 5 arguments, but only 1 given
kernel/sys.c:284: error: `sys_keyctl' defined both normally and as an alias
kernel/sys.c:284: warning: `syscall_linkage' attribute only applies to function types

In include/linux/key.h, sys_request_key and sys_keyctl are defined as
macros :

#define sys_request_key(a,b,c,d,e)      (-ENOSYS)
#define sys_keyctl(a,b,c,d,e)           (-ENOSYS)

But in kernel/sys.c, we find:

cond_syscall(sys_request_key)
cond_syscall(sys_keyctl)

Which expects these symbols to be real functions, it seems.
