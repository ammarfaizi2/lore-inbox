Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUJTOmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUJTOmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUJTOiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:38:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268497AbUJTOgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:36:24 -0400
Date: Wed, 20 Oct 2004 10:36:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Module compilation
Message-ID: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In Makefiles for compiling modules before the new
kernel build procedure, we would just build up
a gcc command-line with the correct parameters
and definitions, i.e. :

CC = gcc -Wall -O2 -etc -etc

DEFINES = -DMODULE -D__KERNEL__ -DONE=1 -DTWO=2 -DETC=etc

CC += $(DEFINES)

In this manner, one could dynamically change definitions
(-DEFINES) being passed to the compiler. The problem is
that the new compile procedure doesn't allow this. It
is possible to 'cheat' and add a string to CFLAGS like

CFLAGS += -DONE=1 -DTWO=2 -DETC=etc

...but it's not CFLAGS that needs to be modified, it's
a named variable that doesn't exist yet, perhaps "USERDEF",
or "DEFINES". I see that the normal "defines" is a constant 
called "CHECKFLAGS", so this isn't appropriate for user
modification.

Could whomever remade the kernel Makefile, please add
a variable, initially set to "", like CFLAGS_KERNEL, that
is exported and is always included on the compiler command-
line?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
