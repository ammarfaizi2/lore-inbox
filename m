Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSJJOBz>; Thu, 10 Oct 2002 10:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSJJOBz>; Thu, 10 Oct 2002 10:01:55 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:54955 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261584AbSJJOBz>; Thu, 10 Oct 2002 10:01:55 -0400
Subject: Re: Patch: linux-2.5.41/drivers/ide - build IDE as a module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Andre Hedrick <andre@linux-ide.org>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021010064457.A460@baldur.yggdrasil.com>
References: <20021010064457.A460@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 15:18:36 +0100
Message-Id: <1034259516.6463.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 14:44, Adam J. Richter wrote:
> 	1. For the time being, I have reassembled some of the
> drivers/ide object files into ide-mod.o again, because there are some
> circular references (not necessarily a bad thing) that modprobe cannot
> otherwise handle.  For now, this includes putting ide-probe in
> ide-mod.

I don't think that is actually avoidable. We end up with a lump that I'd
probably call "ide-core" which is fine.

> 	2. I have changed cmd640.o and legacy.o from dep_bool to
> dep_tristate and made them also depend on $CONFIG_BLK_DEV_IDE, so
> that they will only be offered as modules if ide-mod.o is a
> module (since, like any IDE driver, they require some symbols in
> ide-mod.o).

Sounds right

> 	These changes are probably not perfect, but I think they
> should be an improvement with no real disadvantages in comparison to
> what they replace, so I would encourage you to integrate the changes
> if you see no problem.  Please let me know what you want to do, or if
> there is something more you'd like me to do regarding this patch.

I'll go over it again, but I have no major problem with applying them
and working from there to clean up the corners. Firstly however do one
little thing - dont put extern blah() in the code, add them to the right
header files.

