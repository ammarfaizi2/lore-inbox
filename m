Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268857AbRG0OVG>; Fri, 27 Jul 2001 10:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbRG0OU4>; Fri, 27 Jul 2001 10:20:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52487 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268857AbRG0OUk>; Fri, 27 Jul 2001 10:20:40 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: pauld@egenera.com (Philip R. Auld)
Date: Fri, 27 Jul 2001 15:21:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <no.id> from "Philip R. Auld" at Jul 27, 2001 10:16:59 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q8Uz-0005l0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> This is something that is not present in other unix filesystems as far as I can
> tell. If linux wants to be used in enterprise sites we can't allow 
> old data blocks to be read. And ideally shouldn't allow zero blocks to be seen
> either, but this is somewhat less serious.

> I cannot reproduce this in ufs on either freebsd or solaris8.

It can happen on UFS. What normally happens on UFS is that you get an old
file attached to a new filename when the file is deleted and the inode
reused.

Basically it can happen on any no data logging fs (with a few exceptions for
other clever algorithms like tree-phase)

If you write the metadata block first (UFS) then there is a risk of getting
someone elses data appended to the end of a file (eg length updated before
data blocks). If you write data first there is a risk of writing the data
and never committing the removal of the block from previous files.

FreeBSD softupdates probably make it very hard to trigger and they are a
very nice approach
