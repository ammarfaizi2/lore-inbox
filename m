Return-Path: <linux-kernel-owner+w=401wt.eu-S932382AbXARNES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXARNES (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbXARNES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:50511 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293AbXARNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:16 -0500
Message-Id: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:49 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [patch 00/26] Dynamic kernel command-line
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has already been posted by Alon Bar-Lev <alon.barlev@gmail.com>
in 2nd Dec 2006. He didn't get any response.  Because I think that this
patch would be really useful being able to increase the command line, I
post this patch again to get some response.

This patches are against 2.6.20-rc4-mm1.

Current implementation stores a static command-line buffer allocated to
COMMAND_LINE_SIZE size. Most architectures stores two copies of this
buffer, one for future reference and one for parameter parsing.

Current kernel command-line size for most architecture is much too small
for module parameters, video settings, initramfs parameters and much
more. The problem is that setting COMMAND_LINE_SIZE to a grater value,
allocates static buffers.

In order to allow a greater command-line size, these buffers should be
dynamically allocated or marked as init disposable buffers, so unused
memory can be released.

This patch renames the static saved_command_line variable into
boot_command_line adding __initdata attribute, so that it can be
disposed after initialization. This rename is required so applications
that use saved_command_line will not be affected by this change.

It reintroduces saved_command_line as dynamically allocated buffer to
match the data in boot_command_line.

It also mark secondary command-line buffer as __initdata, and copies it
to dynamically allocated static_command_line buffer components may hold
reference to it after initialization.

This patch is for linux-2.6.19 and is divided to target each
architecture. I could not check this in any architecture so please
forgive me if I got it wrong.

The per-architecture modification is very simple, use boot_command_line
in place of saved_command_line. The common code is the change into
dynamic command-line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

