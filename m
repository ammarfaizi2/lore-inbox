Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268549AbUHLNLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268549AbUHLNLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268552AbUHLNLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:11:33 -0400
Received: from the-village.bc.nu ([81.2.110.252]:64724 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268549AbUHLNKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:10:53 -0400
Subject: Re: 2.6.x Fork Problem?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Torin Ford <code-monkey@qwest.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <006101c47fff$8feedac0$0200000a@torin>
References: <006101c47fff$8feedac0$0200000a@torin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092312514.21994.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 13:08:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 01:01, Torin Ford wrote:
> I've widdled the code down to just do this:
> 
> pid = fork();
> switch (pid)
> {
>    case -1:
>       blah; /* big trouble */
>       break;
>    case 0: /* Child */
>       exit(1);
>       break;
>    default: /* Parent */
>       pid2 = waitpid(pid, &status, 0);
>       if (pid2 == -1)
>       {
>          blah;  /* check out errno */
>       }
> }
> 
> and I get the same results, so I now the exec has nothing to do with it.

Well I see two oddities in the example. You call exit() not _exit() so
the child will duplicate various queued stdio of the parent. Doesn't
seem to be relevant however.

Secondly and I suspect of importance you don't do anything with SIGCLD
so you are inheriting a random status. If the child signal is being
ignored then it will be cleared automatically. In that situation your
code functionality depends solely upon which thread runs first.

