Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTJMCOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 22:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTJMCOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 22:14:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:24018 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261569AbTJMCN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 22:13:59 -0400
Date: Sun, 12 Oct 2003 19:17:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: roland@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] report user-readable fixmap area in /proc/PID/maps
Message-Id: <20031012191706.02c22aab.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310121845100.12190-100000@home.osdl.org>
References: <200310130135.h9D1Zajj008309@magilla.sf.frob.com>
	<Pine.LNX.4.44.0310121845100.12190-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> If you really want /proc/PID/maps to look right, add a new vm_area_struct,
>  see if you can allocate it as part of the "struct mm_struct" so that we
>  don't get yet another (unnecessary) allocation on fork time.

It could be done "on demand".  So get_user_pages() and the /proc code will
call the new add_fixmap_vma() on entry.  Hence the additional overhead is
only incurred when /proc/pid/maps is accessed, or get_user_pages() is
called.

It'll need a new flag in mm_struct.  mm_struct.swap_address can be
salvaged: it is no longer used.

