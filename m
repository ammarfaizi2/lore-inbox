Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUGZHAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUGZHAH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 03:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUGZHAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 03:00:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:65188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264937AbUGZHAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 03:00:00 -0400
Date: Sun, 25 Jul 2004 23:57:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040725235705.57b804cc.akpm@osdl.org>
In-Reply-To: <16734.1090513167@ocs3.ocs.com.au>
References: <16734.1090513167@ocs3.ocs.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
>  * How do we get a clean API to do polling mode I/O to disk?

We hope to not have to.  The current plan is to use kexec: at boot time, do
a kexec preload of a small (16MB) kernel image.  When the main kernel
crashes or panics, jump to the kexec kernel.  The kexec kernel will hold a
new device driver for /dev/hmem through which applications running under
the kexec'ed kernel can access the crashed kernel's memory.

Write the contents of /dev/hmem to stable storage using whatever device
drivers are in the kexeced kernel, then reboot into a real kernel again.

That's all pretty simple to do, and the quality of the platform's crash
dump feature will depend only upon the quality of the platform's kexec
support.

People have bits and pieces of this already - I'd hope to see candidate
patches within a few weeks.  The main participants are rddunlap, suparna
and mbligh.

