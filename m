Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVBXP07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVBXP07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVBXO4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:56:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39396 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262364AbVBXOsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:48:22 -0500
Message-Id: <200502241448.j1OEmJ4N029258@laptop11.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Usage of EXTRA_CFLAGS 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 24 Feb 2005 11:48:19 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 24 Feb 2005 11:48:21 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here (sparc64) I get build failures due to EXTRA_CFLAGS being set in
arch/sparc64/kernel/Makefile:

  EXTRA_CFLAGS := -Werror

But if I override this setting (broken, filesistems use clear_user(),
discard the result and have comments justifiying this) on the make run like

  make EXTRA_CFLAGS= all

the build fails in security/selinux/avc.c, since security/selinux/Makefile
adds:

  EXTRA_CFLAGS += -Isecurity/selinux/include

For now, I edited arch/sparc64/Makefile. There has to be some way to
control stuff like -Werror independently of other stuff (or perhaps the
SELinux Makefile got it wrong?).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
