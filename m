Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbUAHIXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 03:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUAHIXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 03:23:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:41365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263723AbUAHIXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 03:23:09 -0500
Date: Thu, 8 Jan 2004 00:23:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: a new version of memory hotremove patch
Message-Id: <20040108002329.3faee471.akpm@osdl.org>
In-Reply-To: <20040108073634.8A9947007A@sv1.valinux.co.jp>
References: <20040108073634.8A9947007A@sv1.valinux.co.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IWAMOTO Toshihiro <iwamoto@valinux.co.jp> wrote:
>
> - If a page is in mapping->io_pages when remap happens, it will be
>    moved to dirty_pages.  Tracking page->list to find out the list
>    which page is connected to would be too expensive, and I have no other
>    idea.

That sounds like a reasonable thing to do.  The only impact would be that
an fsync() which is currently in progress could fail to write the page, so
the page is still dirty after the fsync() returns.

If this is the biggest problem, you've done well ;)
