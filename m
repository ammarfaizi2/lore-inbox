Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTHCEPS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 00:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTHCEPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 00:15:18 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:43018
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S270272AbTHCEPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 00:15:16 -0400
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Roland McGrath <roland@redhat.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200308021908.h72J82x10422@magilla.sf.frob.com>
References: <200308021908.h72J82x10422@magilla.sf.frob.com>
Content-Type: text/plain
Message-Id: <1059884113.20511.7.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 21:15:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 12:08, Roland McGrath wrote:
> In the case of pgrp, you can
> ignore SIGTTIN/SIGTTOU and progress to some degree at user level.  In the
> case of uids/gids, you can change every thread individually.)

In my case I'm getting read() returning EIO when it tries to read from
the terminal, because the thread pgid doesn't equal the terminal
foreground pgid.  I could solve this problem if either setpgid sets the
pgid in all threads in the thread group, or if I could run setpgid in
all threads for myself (I would prefer the latter just because it is a
bit more flexible).  The current situation is just annoyingly broken
because there's no user-space way to fix it.

	J

