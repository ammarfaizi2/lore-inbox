Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUC1JA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 04:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUC1JA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 04:00:59 -0500
Received: from main.gmane.org ([80.91.224.249]:42463 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262119AbUC1JA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 04:00:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: michael.mauch@gmx.de (Michael Mauch)
Subject: Re: Oracle SHM values?
Date: Sun, 28 Mar 2004 00:45:22 +0100
Organization: no
Message-ID: <i9ghj1xbpg.ln2@elmicha.333200002251-0001.dialin.t-online.de>
References: <20040310184013.GB17760@rdlg.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508e3c24.dip.t-dialin.net
User-Agent: tin/1.6.2-20030910 ("Pabbay") (UNIX) (Linux/2.6.5-rc2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:

> I have users who need this:
> set the following in  /usr/src/linux/include/asm/shmparam.h
> SHMMAX  128MB
> SHMMIN     1
> SHMMNI     100
> SHMSEG      10
>
> and following in    /usr/src/linux/inlude/linux/sem.h
>
> SEMMNI       100
> SEMMSL       60
> SEMMNS      110
> SEMOPM       100
> SEMVMX      32767

> then recompile and install.

> Is there a way to pass these values via append, or anything other than
> having a one-off custom kernel config?

You can set some of them with sysctl:

% sysctl -a | egrep "sem|shm"
kernel.sem = 250        32000   32      128
kernel.shmmni = 4096
kernel.shmall = 2097152
kernel.shmmax = 33554432

The order of the space separated list in kernel.sem is semmsl semmns
semopm semmni (see /usr/src/linux/ipc/sem.c).

I guess the "missing" variables are no longer needed in kernel 2.4/2.6.

Regards...
		Michael

