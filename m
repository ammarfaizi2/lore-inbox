Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265092AbTIJPvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbTIJPvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:51:53 -0400
Received: from [63.205.85.133] ([63.205.85.133]:1785 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S265092AbTIJPvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:51:52 -0400
Date: Wed, 10 Sep 2003 09:00:02 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: netconsole
Message-ID: <20030910160002.GB84652@gaz.sfgoth.com>
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel> <p73znhdhxkx.fsf@oldwotan.suse.de> <20030910082435.GG4489@waste.org> <20030910082908.GE29485@wotan.suse.de> <20030910090121.GH4489@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910090121.GH4489@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> And no, I don't think there's much that can be done to fix it, short
> of putting in deadlock avoidance of some sort or auditing drivers. We
> run a risk of infinite recursion if we manage to avoid the deadlock
> anyway.

No, we won't infinately recurse - read the code around
"down_trylock(&console_sem)" in printk().  Basically if printk() gets
called recursively the data will just be written to the buffer and
the console driver won't get called until later.

The netconsole problem is only if the net driver calls printk() with
its spinlock held (but when not called from netconsole).  Then printk()
won't know that it's unsafe to re-enter the network driver.

-Mitch
