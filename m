Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUCPKnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUCPKnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:43:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:57811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262829AbUCPKnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:43:09 -0500
Date: Tue, 16 Mar 2004 02:43:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kristian Soerensen <ks@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Recovering ext3 - recovery.c: assertion failed,
 attempted to kill init
Message-Id: <20040316024309.53da4f50.akpm@osdl.org>
In-Reply-To: <1079430906.19929.10.camel@homer.cs.auc.dk>
References: <1079430906.19929.10.camel@homer.cs.auc.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Soerensen <ks@cs.auc.dk> wrote:
>
> After (hard) power cycling a computer, running linux-2.6.3*, the
>  filsystem (ext3) sould be recovered at boot. However I get the following
>  message from the kernel. I have tried booting the redhat
>  kernel-2.4.20-30.9 - but with the same result.
> 
>  * The kernel was patched with our Umbrella LSM module, but however _no_
>  changes were made to the filesystem.
> 
> ...
> 
>  Assertion failure in jread() at fs/jbd/recovery.c:140: "offset <
>  journal->j_maxlen"

A wrecked journal superblock or log block.  Never seen that before.

See if e2fsck can fix it up.  If not, see if you can get e2fsck to remove
the journal with

	tune2fs -O ^has_journal /dev/hdXX

then fsck it, then create a new journal with

	tune2fs -j /dev/hdXX

As for the assertion failure: yes, that's fairly bad form.  I'll fix that
up to simply fail the mount.

