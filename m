Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTAaFDi>; Fri, 31 Jan 2003 00:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbTAaFDi>; Fri, 31 Jan 2003 00:03:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:40397 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267583AbTAaFDh>;
	Fri, 31 Jan 2003 00:03:37 -0500
Date: Thu, 30 Jan 2003 21:13:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jared Young <headgeek@li.nu-x.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small bug in linux-2.4.20/include/linux/kernel.h
Message-Id: <20030130211305.5127a678.akpm@digeo.com>
In-Reply-To: <20030130235853.7a2b4dcb.headgeek@li.nu-x.net>
References: <20030130235853.7a2b4dcb.headgeek@li.nu-x.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 05:12:23.0600 (UTC) FILETIME=[569E2300:01C2C8E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jared Young <headgeek@li.nu-x.net> wrote:
>
> Perhaps this is a small bug: During a compile for 2.4.20 there comes a
> section in /include/linux/kernel.h that calls for #include <stdarg.h>
> however stdarg.h is not included or found in any of the source directories.
>

I was bitten by this when I built up gcc-3.2.1.

In earlier gcc's you could have

	ln -s /usr/local/gcc-3.0/bin/gcc /usr/local/bin/gcc

and it would all work OK.

But in recent gcc's, that does not work.  You actually have to add
/usr/local/gcc-3.2.1/bin to your $PATH, and execute gcc from there.

The problem also goes away when you remove -notsdinc from the kernel
makefiles.  So it seems that something changed in the way in which gcc
locates the compiler-provided headers.

In short: check your compiler setup.

