Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbUKXFli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUKXFli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 00:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKXFlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 00:41:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:60818 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261819AbUKXFld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 00:41:33 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Organization: Deban GNU/Linux Homesite
In-Reply-To: <87pt237se1.fsf@devron.myhome.or.jp>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CWpuE-0002Tu-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 24 Nov 2004 06:41:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <87pt237se1.fsf@devron.myhome.or.jp> you wrote:
> Current fatfs is not keeping the consistency of data on the disk at
> all.  So, after all, the data on a disk is corrupting until all
> syscalls finish, right?

Me thinks, fat is pretty robust, and with the small window it improves,
because most users will wait until the operation finished and unplug then.
Which is enough delay for scheduled sync, but not for delayed flushed blocks.

> If so, isn't this too slow? I doubt this is good solution for this
> problem (USB key unplugging)...

Hmm... Actually a "better" solution which involves a journalling filesystem
is not an option for most fat users becaue they need the interoperability.

So the only real solutions you have (beside educating the user to wait for
sync) is to make the corruption window smaller and perhaps do some
reordering on meta data changed to lower the dangers of corruptions.

> Well, it seems good as start of sync-mode though.

You mean, to build sync writes at the right places in the fatfs? I guess yes
that would be even better, so you have kind of soft updates for fat :)
However dont know how reliable the flash controllers are with reordering (if
they are somewhat smart)

How about having configurable sync intervalls per fs/device and default them
to 0 for removeable media?

Greetings
Bernd
