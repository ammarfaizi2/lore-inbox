Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbULKAWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbULKAWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 19:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbULKAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 19:22:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:35265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261890AbULKAWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 19:22:09 -0500
Date: Fri, 10 Dec 2004 16:26:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Konstantin Kletschke <lists@ku-gbr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do klogd and syslogd influence code execution timing?
Message-Id: <20041210162623.1c749f58.akpm@osdl.org>
In-Reply-To: <20041210152107.GA23594@synertronixx3>
References: <20041210152107.GA23594@synertronixx3>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Kletschke <lists@ku-gbr.de> wrote:
>
> It is absolutely _required_ that we start syslogd and klogd before
> inserting the storage device.

The difference is that if klogd is running, a printk() will cause a wakeup
to be delivered to klogd in release_console_sem().  That will cause the CPU
to go into the scheduler code, take and release locks, take more time, etc.

