Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUF0WQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUF0WQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUF0WQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 18:16:16 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:34831 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264501AbUF0WQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 18:16:14 -0400
Date: Mon, 28 Jun 2004 00:16:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Steve G <linux_4ever@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x signal handler bug
Message-ID: <20040627221612.GA16664@pclin040.win.tue.nl>
References: <20040626143326.50865.qmail@web50607.mail.yahoo.com> <Pine.LNX.4.58.0406260839460.10038@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406260839460.10038@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 09:05:34AM -0700, Davide Libenzi wrote:

> You're receiving a SIGSEGV while SIGSEGV is blocked (force_sig_info). The 
> force_sig_info call wants to send a signal that the task can't refuse 
> (kinda The GodFather offers ;). The kernel will noticed this and will 
> restore the handler to SIG_DFL.

Yes.

So checking whether this is POSIX conforming:

- Blocking a signal in its signal handler is explicitly allowed.
  (signal(3p))
- It is unspecified what longjmp() does with the signal mask.
  (longjmp(3p))
- The SIGSEGV that occurs during a stack overflow is of the GodFather kind.
  (getrlimit(3p))
- If SIGSEGV is generated while blocked, the result is undefined
  (sigprocmask(3p))

So, maybe the restoring to SIG_DFL was not required, but it doesnt seem
incorrect either. It may be a bit surprising.

Andries
