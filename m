Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTKNVPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTKNVPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:15:55 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9969 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262288AbTKNVPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:15:54 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 14 Nov 2003 22:15:45 +0100 (MET)
Message-Id: <UTC200311142115.hAELFjt09878.aeb@smtp.cwi.nl>
To: torvalds@osdl.org, willy@debian.org
Subject: Re: [PATCH] Fix XFree86 build
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	--- a/include/linux/kd.h	29 Jul 2003 17:02:13 -0000	1.1
	+++ b/include/linux/kd.h	14 Nov 2003 20:18:38 -0000

	+#ifdef __KERNEL__

>From maintaining things like mount and kbd I can tell you
that it is hopeless to try and have user space source that
is source compatible with all kernel source versions.

Today the rule is "avoid including kernel includes".
Thus, one has to write

  /* from <linux/kd.h> */
  struct kbd_repeat {
          int delay;        /* in msec; <= 0: don't change */
          int period;       /* in msec; <= 0: don't change */
  };

or so, repeating the kernel include data in the user source.

Usually this is not too bad. It only gets really messy if the
kernel definitions are architecture-dependent.

On the other hand, the kernel is fairly good at staying
binary compatible. Thus, such copies in user space code
do not harm so much - once copied, they tend to remain correct.

Of course everybody hates this situation, and several people
have proposed action to remedy. I think you were one.
I did too, and got half a dozen replies from people who would like to
help constructing a kernel include hierarchy suitable for user space.

But we don't have it yet.

Andries
