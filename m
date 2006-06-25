Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWFYXn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWFYXn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWFYXn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:43:28 -0400
Received: from mx1.pretago.de ([89.110.132.150]:45477 "EHLO mx1.pretago.de")
	by vger.kernel.org with ESMTP id S964901AbWFYXn1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:43:27 -0400
From: Markus Schoder <lists@gammarayburst.de>
To: linux-kernel@vger.kernel.org
Subject: ia32 binfmt problem with x86-64
Date: Mon, 26 Jun 2006 01:43:16 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606260143.16362.lists@gammarayburst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 32 bit emulation for x86-64 has the following in 
arch/x86_64/ia32/ia32_binfmt.c:

#define elf_read_implies_exec(ex, have_pt_gnu_stack)	  \
  (!(have_pt_gnu_stack))

I guess it should be same definition as in include/asm-i386/elf.h and 
include/asm-x86_64/elf.h instead:

#define elf_read_implies_exec(ex, executable_stack) \
  (executable_stack != EXSTACK_DISABLE_X)

>From the usage in fs/binfmt_elf.c it looks like the semantics of that 
macro changed slightly but was not fixed in all places (ia64 seems to 
have a similar problem from the looks of it).

The current behavior leads to 32 bit executables not setting the 
READ_IMPLIES_EXEC personality when they are marked as requiring an 
executable stack (64 bit executables do however).

--
Markus
