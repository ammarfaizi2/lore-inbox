Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbTCZLQY>; Wed, 26 Mar 2003 06:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbTCZLQY>; Wed, 26 Mar 2003 06:16:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:35297 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261526AbTCZLQW>;
	Wed, 26 Mar 2003 06:16:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 26 Mar 2003 12:27:29 +0100 (MET)
Message-Id: <UTC200303261127.h2QBRTt05048.aeb@smtp.cwi.nl>
To: corryk@us.ibm.com, linux-kernel@vger.kernel.org
Subject: struct dm_ioctl
Cc: joe@fib011235813.fsnet.co.uk, lvm-devel@sistina.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main users of dev_t in the userspace-kernel interface
are mknod and stat. But there is a small collection of
more obscure interfaces that use a dev_t parameter
(like the ustat system call) or a dev_t field in a
parameter struct (for example, struct loopinfo,
struct nfsctl_export, struct dm_ioctl).

It is almost always a mistake to have an interface
with a dev_t field, since nobody knows the size of
a dev_t field. The kernel size differs from the user
space size, the libc5 size differs from the glibc size.
A struct with such a field therefore has unknown size,
the fields following the dev_t field have unknown offset,
and lots of troubles arise.
Such interfaces are broken from the start.

But there are a few and we must deal with them one by one.

One is struct dm_ioctl. Google tells me that it was
noticed already that it defined a broken interface,
and Kevin Corry submitted a patch against 2.5.51.
Today this has not been applied yet.

What is the status? Should I resubmit that patch?

[http://marc.theaimsgroup.com/?l=linux-kernel&m=103956089203199&w=3]

Andries
