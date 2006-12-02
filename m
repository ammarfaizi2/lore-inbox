Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759463AbWLBK7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759463AbWLBK7V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759459AbWLBK7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759454AbWLBK7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fnfq4CaeD4cvuqm4Rh1EotW6BvLoYN9rMdn5hw/BjBboJGygTe1U3tTXhK4SjjB98bGNEhH2L1bhGP/mVVyz46hBLsKnk8/nd7rumdnXZIq5OArp3Z9b56Cl2NwvhkzaAttuuUSC3HUPE9MewuPMCfQ70Fl2qSX61WFh1NlPySQ=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/26] Dynamic kernel command-line
Date: Sat, 2 Dec 2006 12:47:41 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021247.43291.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

This is take 3 of submission, I submit this patch
once in a few monthes to collect some more signatures :)
Until now, I got three:
- avr32
- sh
- sh64

I know this is not one of major priorities, but it
should be simple enough to be reviewed and included.

I will also be happy to get a REJECT response, so I
stop trying to get it included. Any suggestions of
how to push this farward will also be appreciated.

Current implementation stores a static command-line
buffer allocated to COMMAND_LINE_SIZE size. Most
architectures stores two copies of this buffer, one
for future reference and one for parameter parsing.

Current kernel command-line size for most architecture
is much too small for module parameters, video settings,
initramfs paramters and much more. The problem is that
setting COMMAND_LINE_SIZE to a grater value, allocates
static buffers.

In order to allow a greater command-line size, these
buffers should be dynamically allocated or marked
as init disposable buffers, so unused memory can be
released.

This patch renames the static saved_command_line
variable into boot_command_line adding __initdata
attribute, so that it can be disposed after
initialization. This rename is required so applications
that use saved_command_line will not be affected
by this change.

It reintroduces saved_command_line as dynamically
allocated buffer to match the data in boot_command_line.

It also mark secondary command-line buffer as __initdata,
and copies it to dynamically allocated static_command_line
buffer components may hold reference to it after
initialization.

This patch is for linux-2.6.19 and is divided to
target each architecture. I could not check this in any
architecture so please forgive me if I got it wrong.

The per-architecture modification is very simple, use
boot_command_line in place of saved_command_line. The
common code is the change into dynamic command-line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

