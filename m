Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbUAIDlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUAIDlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:41:15 -0500
Received: from pat.uio.no ([129.240.130.16]:49088 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264104AbUAIDlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:41:03 -0500
Message-ID: <33532.141.211.133.197.1073619655.squirrel@webmail.uio.no>
Date: Fri, 9 Jan 2004 04:40:55 +0100 (CET)
Subject: Re: [NFS] Re: [NFS client] NFS locks not released on abnormal process termination
From: <trond.myklebust@fys.uio.no>
To: <yamamoto@valinux.co.jp>
In-Reply-To: <1073616986.525187.4709.nullmailer@yamt.dyndns.org>
References: <35311.68.42.103.198.1073580656.squirrel@webmail.uio.no>
        <1073616986.525187.4709.nullmailer@yamt.dyndns.org>
X-Priority: 3
Importance: Normal
Cc: <phil@fifi.org>, <theonetruekenny@yahoo.com>,
       <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.11 - UIO)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.74, required 12,
	BAYES_00 -4.90, NO_REAL_NAME 0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The RPC layer blocks all signals except SIGKILL, so the signalled
>> process has no choice but to exit immediately if something gets
>> through.
>
> we're talking about interruptible mounts, aren't we?
>
> are you referring to rpc_clnt_sigmask() ?
> i think it isn't safe to assume sa_handler isn't changed during
> blocking for lock.  consider CLONE_SIGHAND, for example.

So what? If you decide handle a signal, then you are taking full
responsibility for the recovery process. It is up to _you_ to take action
to either recover the lock or to undo it, not the kernel. To determine
whether or not the lock was taken on the server you can just do a
fcntl(GETLK) call.

All the kernel cares about is that when the process exits, it needs to
clean up all the locks that are owned by that pid.

Cheers,
  Trond


