Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270176AbUJTK0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270176AbUJTK0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269939AbUJSWTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:19:06 -0400
Received: from almesberger.net ([63.105.73.238]:1548 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S269913AbUJSWHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:07:38 -0400
Date: Tue, 19 Oct 2004 19:07:05 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de,
       =?iso-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko.hyvatti@iki.fi>
Subject: [PATCH] no TIOCSBRK/TIOCCBRK in ia32 emulation on amd64
Message-ID: <20041019190705.J18873@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ia32 emulation, the amd64 kernel refuses the ioctls TIOCSBRK
and TIOCCBRK with EINVAL. I've attached a patch that adds them to
the compatibility list.

Since all architectures have these ioctls ("m68knommu" inherits
them from "m68k", "um" from its host) and use the same code, I
think adding them to compat_ioctl.h is the correct choice (as
opposed to adding them to arch/x86_64/ia32/ia32_ioctl.c).

The patch is for 2.6.9. I've observed the problem the first time
in 2.6.7.

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.9/include/linux/compat_ioctl.h.orig	2004-10-19 18:52:50.406756352 -0300
+++ linux-2.6.9/include/linux/compat_ioctl.h	2004-10-19 18:56:34.057756232 -0300
@@ -23,6 +23,8 @@
 COMPATIBLE_IOCTL(TCSETSW)
 COMPATIBLE_IOCTL(TCSETSF)
 COMPATIBLE_IOCTL(TIOCLINUX)
+COMPATIBLE_IOCTL(TIOCSBRK)
+COMPATIBLE_IOCTL(TIOCCBRK)
 /* Little t */
 COMPATIBLE_IOCTL(TIOCGETD)
 COMPATIBLE_IOCTL(TIOCSETD)

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
