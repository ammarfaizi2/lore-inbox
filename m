Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTJEKnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 06:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbTJEKnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 06:43:32 -0400
Received: from 86.Red-80-24-13.pooles.rima-tde.net ([80.24.13.86]:9999 "EHLO
	aragorn") by vger.kernel.org with ESMTP id S263062AbTJEKna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 06:43:30 -0400
Date: Sun, 5 Oct 2003 12:42:07 +0000
From: Robert Millan <zeratul2@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: external (userland) inclussion of <linux/*.h>
Message-ID: <20031005124207.GA1254@aragorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: free as in freedom
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

It is well known that Linux headers, which distributors put in /usr/include
in order to be used by Glibc, are often abused and mistakenly included by
userspace programs that don't actualy need kernel-specific features.

For example, some programmers prefer to include <linux/limits.h> instead of
<limits.h> to get a limit macro and break for all non-Linux-based systems while
they are at it.

When including a header directly is a wrong thing, the general tendency is to
simply disallow it. For example, Glibc headers use preprocessor commands in
the style of:

  #ifndef _STDIO_H
  # error "Never include <bits/stdio.h> directly; use <stdio.h> instead."
  #endif

Since there are a few legitimate uses of <linux/*.h> for userspace programs,
one could allow such by using the proper macro, something like:

  #ifndef _LINUX_SOURCE
  # error "blah"
  #endif

If you like the idea, I can send a patch for all this.

-- 
Robert Millan

"[..] but the delight and pride of Aule is in the deed of making, and in the
thing made, and neither in possession nor in his own mastery; wherefore he
gives and hoards not, and is free from care, passing ever on to some new work."

 -- J.R.R.T, Ainulindale (Silmarillion)
