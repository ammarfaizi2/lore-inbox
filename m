Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312797AbSDGRYr>; Sun, 7 Apr 2002 13:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313330AbSDGRYq>; Sun, 7 Apr 2002 13:24:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51718 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312797AbSDGRYq>; Sun, 7 Apr 2002 13:24:46 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: shirsch@adelphia.net (Steven N. Hirsch)
Date: Sun, 7 Apr 2002 18:42:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204071240360.15439-100000@atx.fast.net> from "Steven N. Hirsch" at Apr 07, 2002 12:43:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uGg1-0006Ln-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And, unless this is reversed the OpenAFS kernel module won't load (it 
> needs sys_call_table.):

Correct. There was agreement a very long time ago that code should not patch
the syscall table (for one its not safe). AFS probably needs fixing so the
AFS syscall hook is exported portably and nicely in the syscall code.

This wants fixing in 2.5 too - basically

static int (*afs_syscall)(...);
sys_afs_syscall(...)
{
	if(afs_syscall)
		return afs_syscall(....)
	return -ENOSYS;
}

EXPORT_SYMBOL(afs_syscall)

Alan
