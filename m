Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbVLWNvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbVLWNvD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 08:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbVLWNvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 08:51:03 -0500
Received: from pat.uio.no ([129.240.130.16]:17074 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030498AbVLWNvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 08:51:01 -0500
Subject: Re: nfs insecure_locks / Tru64 behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051223133801.GA9321@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu>
	 <1135293713.3685.9.camel@lade.trondhjem.org>
	 <20051223013933.GB22949@mtholyoke.edu>
	 <1135302325.3685.69.camel@lade.trondhjem.org>
	 <20051223022126.GC22949@mtholyoke.edu>
	 <1135327075.8167.6.camel@lade.trondhjem.org>
	 <20051223133801.GA9321@mtholyoke.edu>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 14:50:12 +0100
Message-Id: <1135345813.8167.155.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.285, required 12,
	autolearn=disabled, AWL 1.67, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 08:38 -0500, Ron Peterson wrote:
> The gid's of the kmw group match on both sides.  The problem happens
> whether root squashing is on or off.  Unless the execute bit for 'other'
> is turned on for the parent directory, the file appears to be locked
> when being accessed from the nfs client (tru64) side.
> 
> My theory may be wrong, but the problem still exists.

Possibly, but that sounds like it might be a tru64 bug. As you can see,
a Linux client has no such problems:

[trondmy@longyearbyen trondmy]$ id
uid=520(trondmy) gid=100(users) groups=10(wheel),100(users)
[trondmy@longyearbyen trondmy]$ ls -al
total 0
drwxr-xr-x  5 trondmy users 36 Dec 23 08:44 .
drwxr-xr-x  3 root    root  20 Jun 17  2005 ..
drwxr-x---  2 root    users 18 Dec 23 08:47 d
drwxr-xr-x  8 root    root  68 Dec  5 01:11 gnurr
drwxr-xr-x  2 trondmy users 30 Nov 23 10:38 tmp
[trondmy@longyearbyen trondmy]$ ls -al d
total 4
drwxr-x---  2 root    users 18 Dec 23 08:47 .
drwxr-xr-x  5 trondmy users 36 Dec 23 08:44 ..
-rw-r--r--  1 root    root   6 Dec 23 08:47 hello
[trondmy@longyearbyen trondmy]$ cat d/hello
hello

Cheers,
  Trond

