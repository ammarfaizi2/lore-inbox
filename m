Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUITVGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUITVGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUITVGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:06:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:1510 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267358AbUITVGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:06:14 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cindco$ats$1@gatekeeper.tmr.com>
References: <cic9os$ibd$1@gatekeeper.tmr.com>
	 <1095263565.19906.19.camel@vertex>
	 <1095352742.23385.148.camel@betsy.boston.ximian.com>
	 <cindco$ats$1@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Mon, 20 Sep 2004 17:05:06 -0400
Message-Id: <1095714306.3666.39.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 16:16 -0400, Bill Davidsen wrote:

> Well, I guess I misread the intent, I was assuming an inode could be 
> watched even if it wasn't (at the time of watch) being used. So while I 
> may want to know when any inode in a directory is used, I don't 
> particularly desire to have them all pinned in memory.
> 
> If you say that's the only way, then clearly only huge system will be 
> able to do that type of monitoring.

You can pin just a directory and retrieve all of the events therein.
You do not need to pin every single inode on your machine.  This is the
same as dnotify - except inotify also allows you to watch individual
files.

> I'm not clear on what race you would get sending a notify to a user mode 
> process that an inode had changed, but if you say there could be one I 
> can't argue.

If you cannot track the lifecycle of the object being watched, you
essentially cannot watch it.  To track the lifetime of an inode, you
need to ensure that it remains in the icache.

> If by modern you mean huge memory servers, you are right. If you mean 
> modest desktops which might be able to identify problems by watching a 
> set of inodes, I suspect the inode usage is lower.
>
> I guess all of us running laptops and the like with memory in MB rather 
> then GB just aren't modern... the limit we hit is mostly memory size.

John showed that the absolute worst case is ~30MB in your icache.  I
have 77MB of ext3 inodes in cache right now on my desktop.  Assuming a
decent overlap between watched and cached inodes, there is little
change.

But the 30MB is worst case.  Expect something in the single digits.

Look, Bill: Conjecturing about a potential problem in a space you are
unfamiliar with does nothing but obstruct Linux development and act as
Stop Energy.  Constructive, well-informed opinions are money.
Everything else is just liking the sound of your voice.

Thanks!

Best,

	Robert Love


