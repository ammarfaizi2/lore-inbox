Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUIECCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUIECCc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUIECCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:02:32 -0400
Received: from pat.uio.no ([129.240.130.16]:59087 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265909AbUIECCa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:02:30 -0400
Subject: Re: why do i get "Stale NFS file handle" for hours?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <413A7119.2090709@upb.de>
References: <chdp06$e56$1@sea.gmane.org>
	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1094349744.13791.128.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 22:02:24 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 04/09/2004 klokka 21:51, skreiv Sven Köhler:

> I agree, but you simply admit that the NFS client doesn't seem to know, 
> when the server was restart. The simpliest thing i can imagine, is that 
> the NFS server generates a random integer-value at start, and transmits 
> it along with ESTALE. If the integer-value is different from the 
> integer-value the server send while mounting the FS, than the kernel has 
> to remount it transparently. This is a simple thing so that a client can 
> safely determine, if the server has been restarted, or not, and it only 
> adds 4 byte to some nfs-packets.

No.... The simplest thing is for the server to actually abide by the
RFCs and not generate filehandles that change on reboot.

NFSv4 is the ONLY version of the protocol that actually supports the
concept of filehandles that have a finite lifetime.

> In my case, if the nfs directory is mounted to /mnt/nfs, i can't even do 
> a simple "cd /mnt/nfs" without getting the "stale nfs handle" - even if 
> i use a different shell. I always thought, that the "cd /mnt/nfs" should 
> work, since the shell will aquire a new handle, but it doesn't work :-(

It won't if the root filehandle is broken too. That is the standard way
of telling the NFS client that the administrator has revoked our access
to the filesystem.

The solution is simple here: fix the broken server...

Cheers,
   Trond

