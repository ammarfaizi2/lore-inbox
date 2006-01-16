Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWAPHng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWAPHng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWAPHng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:43:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932189AbWAPHng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:43:36 -0500
Date: Sun, 15 Jan 2006 23:43:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface
Message-Id: <20060115234300.159688f7.akpm@osdl.org>
In-Reply-To: <200601151831.32021.rjw@sisk.pl>
References: <200601151831.32021.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> This patch introduces a user space interface for swsusp.
> 
> The interface is based on a special character device, called the snapshot
> device, that allows user space processes to perform suspend and
> resume-related operations with the help of some ioctls and the read()/write()
> functions.  Additionally it allows these processes to allocate free swap pages
> from a selected swap partition, called the resume partition, so that they know
> which sectors of the resume partition are available to them.
> 
> The interface uses the same low-level system memory snapshot-handling
> functions that are used by the built-it swap-writing/reading code of swsusp.

The identifiers and terminology are pretty similar to dm-snap.c.  But I
don't see any clashes there.  Yet.

> The interface documentation is included in the patch.
> 
> The patch assumes that the major and minor numbers of the snapshot device
> will be 10 (ie. misc device) and 231, the registration of which has already been
> requested.

Why does it need a statically-allocated major and minor?  misc_register()
will generate a uevent and the device node should just appear...

