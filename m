Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263268AbTCSXwE>; Wed, 19 Mar 2003 18:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263269AbTCSXwE>; Wed, 19 Mar 2003 18:52:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38315 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263268AbTCSXwD>;
	Wed, 19 Mar 2003 18:52:03 -0500
Date: Wed, 19 Mar 2003 16:01:30 -0800 (PST)
Message-Id: <20030319.160130.112180221.davem@redhat.com>
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, ak@suse.de
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030319232157.GA13415@elf.ucw.cz>
References: <20030319232157.GA13415@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Thu, 20 Mar 2003 00:21:57 +0100

   This patche moves common COMPATIBLE_IOCTLs to
   include/linux/compat_ioctl.h, enabling pretty nice cleanups:

Please be careful.  For anything non-trivial there can be major
differences between compat layers.

I say this now because eventually I want this compat stuff
to support multiple-compilations, using some COMPAT_NAME(foo)
macro scheme and some Makefile hackery.

This would allow, for example, x86_64 to have an x86_32 and
x86_32_sysv compat layer in one build.  So for example in this case
fs/compat.c would be built twice, once with x86_32 compat types
and once with x86_32_sysv types.

