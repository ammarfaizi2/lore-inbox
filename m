Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265260AbUD3Uk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUD3Uk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUD3Uk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:40:27 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:29839 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265260AbUD3Uj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:39:59 -0400
Subject: Re: Possible permissions bug on NFSv3 kernel client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1BJeSB-0000Gk-V2@localhost>
References: <1QqNJ-4QH-37@gated-at.bofh.it> <1QqNJ-4QH-39@gated-at.bofh.it>
	 <1QqNJ-4QH-35@gated-at.bofh.it> <1Qrhg-5hH-29@gated-at.bofh.it>
	 <E1BJeSB-0000Gk-V2@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083357597.13656.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Apr 2004 16:39:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 16:17, Pascal Schmidt wrote:
> Then it's at least inconsistent with local filesystem behaviour. fsck
> has no problem opening device nodes for writing on my root filesystem
> even though it is mounted read-only at that point.

So why do you think that is inconsistent with my statement: "the
permissions checking has to be done by the server, period"?

The read-only mount option is a *local* override of the write
permissions on the server. It applies to regular files, directories, and
soft links *only*.
The read-only mount option does *not apply* to char/block devices such
as /dev/hd[a-z]*, /dev/tty*. Permission checks on open() for those
devices are done on the server *only* via the ACCESS rpc call.

This should be entirely consistent with local file behaviour.
Particularly since the code to deal with the read-only mount option in
nfs_permission() was pretty much cut-n-pasted from vfs_permission().

Cheers,
  Trond
