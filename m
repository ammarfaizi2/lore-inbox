Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266655AbUBFHx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUBFHxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:53:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:65419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266655AbUBFHxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:53:21 -0500
Date: Thu, 5 Feb 2004 23:55:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-Id: <20040205235517.2bb4c073.akpm@osdl.org>
In-Reply-To: <20040206041223.A18820@almesberger.net>
References: <20040206041223.A18820@almesberger.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> wrote:
>
> "[...] read( ) [...] shall be atomic with respect to each other
>   in the effects specified in IEEE Std. 1003.1-200x when they
>   operate on regular files. If two threads each call one of these
>   functions, each call shall either see all of the specified
>   effects of the other call, or none of them."

Whichever thread finishes its read last gets to update f_pos.

I'm struggling a bit to understand what they're calling for there.  If
thread A enters a read and then shortly afterwards thread B enters the
read, does thread B see an f_pos which starts out at the beginning of A's
read, or the end of it?

Similar questions apply as the threads exit their read()s.

Either way, there's no way in which we should serialise concurrent readers.
That would really suck for sensible apps which are using pread64().



