Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292407AbSCDO6u>; Mon, 4 Mar 2002 09:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSCDO6n>; Mon, 4 Mar 2002 09:58:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55045 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292402AbSCDO6R>; Mon, 4 Mar 2002 09:58:17 -0500
Subject: Re: ext3 and undeletion
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Mon, 4 Mar 2002 15:12:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jstrand1@rochester.rr.com (James D Strandboge),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020304021714.GB353@matchmail.com> from "Mike Fedyk" at Mar 03, 2002 06:17:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hu8q-00080A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> another inode after the trunc op would break unix semantics.  In order to
> work, you'd have to use a new inode (in .undelete, of course), copy, then do
> the actual trunc call. 
> This would make truncation expensive, whereas before it was pretty fast.
> Modifying unlink will probably suffice.

You would need to hook the truncate/unlink paths in the file system. If 
you are doing it within the fs it becomes cheap (at least for ext2) - as
you can simply reassign the data blocks to a new inode, stuff the new inode
into the magic "stuff we deleted" directory and continue.

