Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266431AbUFZVAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUFZVAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbUFZVAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:00:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:38610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266431AbUFZVAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:00:48 -0400
Date: Sat, 26 Jun 2004 13:59:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: simon@nuit.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot access '/dev/pts/292': Value too large for defined data
 type
Message-Id: <20040626135948.7b4396e9.akpm@osdl.org>
In-Reply-To: <20040626151108.GA8778@nuit.ca>
References: <20040626151108.GA8778@nuit.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simon@nuit.ca wrote:
>
> whenever i try open a new pseudo-pty, i get a similar message to 
>  the one in the subject, and one like "fstat: Value too large for defined data
>  type" if i open an xterm.

It appears that you're using some variant of the 2.6.7 kernel, yes?

That kernel (and many preceding ones) will create large pty indexes and old
(and/or buggy) userspace fails to handle it correctly.

Post-2.6.7, the allocation of pty indexes was switched to first-fit and
things should now work OK.

Please test a current kernel and send a report.

2.6.7 plus
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.7-bk9.gz
would be suitable.
