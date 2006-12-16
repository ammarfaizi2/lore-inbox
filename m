Return-Path: <linux-kernel-owner+w=401wt.eu-S1030299AbWLPF13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWLPF13 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 00:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWLPF13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 00:27:29 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:39663 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386AbWLPF13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 00:27:29 -0500
Date: Fri, 15 Dec 2006 21:28:35 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Mike Accetta <maccetta@laurelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Change in multiple NFS mount behavior in 2.6.19?
Message-Id: <20061215212835.447659c8.randy.dunlap@oracle.com>
In-Reply-To: <45837A24.9040207@laurelnetworks.com>
References: <45837A24.9040207@laurelnetworks.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 23:46:28 -0500 Mike Accetta wrote:

> After upgrading an NFS client from 2.6.18 to 2.6.19 (and also with 
> 2.6.19.1) we see a change in behavior of multiple NFS mounts against the 
> same server (running 2.4.20 in this case).  With 2.6.18 we could mount 
> different pieces of the same remote file system with distinct read-only 
> and read-write attributes at corresponding places on the client.  With 
> 2.6.19 if the first mount is read-only, subsequent mounts seem to 
> inherit the read-only status even though not explicitly mounted read-only.
> 
> If I did the "git bisect" properly, the behavior changed with commit
> 54ceac4515986030c2502960be620198dd8fe25b and the description of this 
> commit seems like it could indeed have caused this behavior, but perhaps 
> not intentionally. I believe the client is making NFS V2 calls. Also, I 
> am still able to issue a "mount -o remount,rw" on the client to regain 
> read-write capability.  Was this a regression or is this now the 
> expected behavior for multiple NFS client mounts in 2.6.19?
> -- 

That would correspond to this bugzilla item, which explains
that multiple mount semantics for one filesystem are all shared.

http://bugzilla.kernel.org/show_bug.cgi?id=7655

---
~Randy
