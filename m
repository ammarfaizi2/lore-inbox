Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUL0RGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUL0RGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUL0RGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:06:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64664 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261928AbUL0RGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:06:37 -0500
Date: Mon, 27 Dec 2004 18:06:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Cannot compile without sysctl (+semi-patch)
Message-ID: <Pine.LNX.4.61.0412271803300.10322@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


in trying to make the smallest possible kernel for an old pc's needs (read: 
386sx) disabling sysctl support (CONFIG_SYSCTL) does not work, sys_setgroups 
and sys_setgroups16 still require it. (I get a linking error.)
It's not a blocker, but it would be nice if this got wrapped up in #ifdef or 
something :-) so that either sysctl is always on or sys_setgroups behaves a 
little different.

Preferably:
include/linux/limits.h:
#ifdef __KERNEL__
extern int ngroups_max;
# define NGROUPS_MAX ngroups_max
#else
# define NGROUPS_MAX __NGROUPS_MAX
#endif

to

#if defined(__KERNEL__) && defined(CONFIG_SYSCTL)
# define NGROUPS_MAX ngroups_max
#else
# define NGROUPS_MAX __NGROUPS_MAX
#endif




Jan Engelhardt
-- 
ENOSPC
