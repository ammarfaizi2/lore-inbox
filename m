Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTILF5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 01:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTILF5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 01:57:39 -0400
Received: from waste.org ([209.173.204.2]:21989 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261683AbTILF5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 01:57:30 -0400
Date: Fri, 12 Sep 2003 00:57:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [PATCH 2/3] netpoll: netconsole
Message-ID: <20030912055725.GV4489@waste.org>
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel> <p73znhdhxkx.fsf@oldwotan.suse.de> <20030910082435.GG4489@waste.org> <20030910082908.GE29485@wotan.suse.de> <20030910090121.GH4489@waste.org> <20030910160002.GB84652@gaz.sfgoth.com> <20030912053335.GJ41254@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912053335.GJ41254@gaz.sfgoth.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 10:33:35PM -0700, Mitchell Blank Jr wrote:
> Mitchell Blank Jr wrote:
> > The netconsole problem is only if the net driver calls printk() with
> > its spinlock held (but when not called from netconsole).  Then printk()
> > won't know that it's unsafe to re-enter the network driver.
> 
> BTW, this isn't neccesarily a netconsole-only thing.  For instance, has
> anyone ever audited all of the serial and lp drivers to make sure that
> nothing they call can call printk() while holding a lock?  This sounds
> fairly serious - we could have any number of simple error cases that would
> cause a deadlock with the right "console=" setting.

I have a spinlock debugging patch somewhere that builds a list of
locks held by each process. It could easily be extended to do
detecting of recursive locking.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
