Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTGHRuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbTGHRuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:50:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:60328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265079AbTGHRuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:50:52 -0400
Date: Tue, 8 Jul 2003 10:59:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.net, davem@redhat.com,
       jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, rddunlap@osdl.org
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
Message-Id: <20030708105912.57015026.akpm@osdl.org>
In-Reply-To: <3F0AFFE6.E85FF283@us.ibm.com>
References: <3F0AFFE6.E85FF283@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Keniston <jkenisto@us.ibm.com> wrote:
>
> The enclosed patches provide a mechanism for reporting error events
> to user-mode applications via netlink.

Seems sane to me.

It needs to handle %z as well as %Z.

The layout of `struct kern_log_entry' may be problematic.  Think of the
situation where a 64-bit kernel constructs one of these and sends it up to
32-bit userspace.  Will the structure layout be the same under the 32-bit
compiler as under the 64-bit one?

How do you actually intend to use this?  Will it be by adding new
evt_printf() calls to particular drivers, or replacing existing printk's or
both?

Would it make sense for evt_printf() to fall back to printk() if nobody is
listening to the log stream?

