Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262047AbSIYSOu>; Wed, 25 Sep 2002 14:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbSIYSOu>; Wed, 25 Sep 2002 14:14:50 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1355 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262047AbSIYSOt>; Wed, 25 Sep 2002 14:14:49 -0400
Date: Wed, 25 Sep 2002 14:19:46 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org, axboe@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] fix ide-iops for big endian archs
Message-ID: <20020925141946.A14230@devserv.devel.redhat.com>
References: <mailman.1032957359.10217.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <mailman.1032957359.10217.linux-kernel2news@redhat.com>; from zaitcev@redhat.com on Wed, Sep 25, 2002 at 02:32:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
> Date: Wed, 25 Sep 2002 14:32:23 +0200

> Curently in 2.5 (afaik in -ac too), the ide-iops "s" routines used
> to transfer datas in/out the data port are incorrect for big endian
> machines. They are implemented with a loop of inw/outw which are
> byteswapping, but a fifo transfer like that mustn't be swapped.

Dunno about ppc, but sparc works just fine as it is in 2.4.
When was the last time you examined include/asm-sparc/ide.h?

IDE uses ide_insw instead of plain insw specifically to
resolve this kind of issue, and you are trying to defeat
the mechanism designed to help you. I smell a fish here.

-- Pete
