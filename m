Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWCAKhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWCAKhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWCAKhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:37:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13284 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964907AbWCAKhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:37:13 -0500
Date: Wed, 1 Mar 2006 02:36:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Aubrey <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure when cached memory is close to the
 total memory.
Message-Id: <20060301023604.76ce5658.akpm@osdl.org>
In-Reply-To: <6d6a94c50603010154hbbcdb68n8cd7e05f7f30aba5@mail.gmail.com>
References: <6d6a94c50603010154hbbcdb68n8cd7e05f7f30aba5@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey <aubreylee@gmail.com> wrote:
>
> I'm working on the blackfin uclinux. And the kernel version is 2.6.12.
>  I have an application to malloc 0Mb memory.

You mean 10MB.

The chances of finding 10MB of contiguous free pages are basically nil, so
the page allocator doesn't even try to free up pages to attempt to satisfy
such a large request.  If it can't find the 10MB of free memory
immediately, it just gives up.

