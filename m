Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266497AbUBGIw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 03:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUBGIw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 03:52:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:3814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266497AbUBGIw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 03:52:56 -0500
Date: Sat, 7 Feb 2004 00:55:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, viro@math.psu.edu
Subject: Re: PATCH - raise max_anon limit
Message-Id: <20040207005505.784307b8.akpm@osdl.org>
In-Reply-To: <20040206221545.GD9155@sun.com>
References: <20040206221545.GD9155@sun.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> Attached is a patch to raise the limit of anonymous block devices.  The
>  sysctl allows the admin to set the order of pages allocated for the unnamed
>  bitmap from 1 page to the full MINORBITS limit.

It would be better to lose the sysctl and do it all dynamically.

Options are:

a) realloc the bitmap when it fills up

   Simple, a bit crufty, doesn't release memory.

b) lib/radix-tree.c

   Each entry in the radix tree can be a bitmap (radix-tree.c should
   have been defined to store unsigned longs, not void*'s.  Oh well), so
   you get good space utilisation, but finding a new entry will take ten or
   so lines of code.

c) lib/idr.c

   Worst space utilisation, but simplest code.


I'd go with c), personally.
