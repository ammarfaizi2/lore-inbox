Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTJXDfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 23:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJXDfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 23:35:46 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:50099 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261957AbTJXDfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 23:35:43 -0400
Message-ID: <06d801c399df$f8af9880$6501a8c0@rhyde>
From: "Randall Hyde" <randyhyde@earthlink.net>
To: <linux-kernel@vger.kernel.org>
References: <102420030310.18374.4e89@comcast.net>
Subject: mmap to Access PCI space?
Date: Thu, 23 Oct 2003 20:36:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I need to access a couple of SATA chips from a user-mode
program (yep, running as root). I know for a fact that my
chip resides at address 0xfc300000 (/proc/iomem and /proc/ide/siimage
tells me this).  Can I do a mmap like the following to access the registers
on ths chip?

fdDevMem = open( "/dev/mem", O_RDWR );
ptr =
    mmap
    (
        NULL,
        4096,
        PROT_READ | PROT_WRITE,
        MAP_SHARED,
        fdDevMem,
        0xfc300000
    );

When I try this, I get a valid pointer back, but it doesn't seem to
be mapped to my si3112 chip register bank.

I've also used code like the following:
ptr =
    mmap
    (
        0xfc300000,
        4096,
        PROT_READ | PROT_WRITE,
        MAP_SHARED | MAP_ANONYMOUS,
        -1,
        0
    );

Same story.
If I use MAP_FIXED and/or MAP_PRIVATE, the mmap call fails.

What am I doing wrong here?
Thanks,
Randy Hyde

