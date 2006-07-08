Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWGHBbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWGHBbB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 21:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWGHBbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 21:31:01 -0400
Received: from xenotime.net ([66.160.160.81]:20650 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751289AbWGHBbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 21:31:01 -0400
Date: Fri, 7 Jul 2006 18:33:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       paulkf@microgate.com, akpm@osdl.org
Subject: Re: [PATCH] Ref counting for tty_struct and some locking clean up
Message-Id: <20060707183348.157cc272.rdunlap@xenotime.net>
In-Reply-To: <9e4733910607071737n1bd01042u92b895edaceb73db@mail.gmail.com>
References: <9e4733910607071737n1bd01042u92b895edaceb73db@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 20:37:36 -0400 Jon Smirl wrote:

> This patch removes tty_mutex and replaces it with a ref counted
> tty_struct. A new spinlock, tty_lock, serializes tty
> creation/destruction. This code thoroughly audits everyone taking
> references to tty_struct and tracks them. I have been running it
> locally for a few days without any issues.
> 
> If there is a refcount problem it will trigger a WARN_ON. If you hit
> one, defining DEBUG_TTY_REFCOUNT will provide plenty of debug info to
> help locate the missing reference. I definitely found multiple locking
> holes in the old tty_mutex code but they they look hard to hit.
> 
> This is just a first step, if this code proves to be stable I'll do
> another round of cleanup. There is room for a lot more work to be
> done. Ultimately there may not even be a need for a tty refcount if
> everything is locked correctly. But that is a big step and we should
> take some smaller ones first.
> 
> This is meant for mm until it gets some testing - I don't want to
> break anyone's console. If gmail wraps it let me know and I'll send
> you an attachment.

It has one wrapped line in it but does not apply cleanly to
2.6.18-rc1 or to 2.6.17-mm6.  What was it diffed against?

---
~Randy
