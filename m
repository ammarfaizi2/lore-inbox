Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUIEBys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUIEBys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 21:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUIEBys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 21:54:48 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:49850 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S265910AbUIEByp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 21:54:45 -0400
Message-ID: <413A7119.2090709@upb.de>
Date: Sun, 05 Sep 2004 03:51:21 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.2) Gecko/20040426
X-Accept-Language: de, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: why do i get "Stale NFS file handle" for hours?
References: <chdp06$e56$1@sea.gmane.org> <1094348385.13791.119.camel@lade.trondhjem.org>
In-Reply-To: <1094348385.13791.119.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.275,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-MailScanner-From: skoehler@upb.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course we could "fix" things for the user so that we just look up all
> those filehandles again transparently.
> 
>   The real question is: how do we know that is the right thing to do?
> 
> The NFS client wouldn't know the difference between your /etc/passwd
> file and a javascript pop-up ad. If it gets an ESTALE error, then that
> tells it that the original filehandle is invalid, but it does not know
> WHY that is the case. The file may have been deleted and replaced by a
> new one. It may be that your server is broken, and is actually losing
> filehandles on reboot (as appears to be the case in your setup),...

I agree, but you simply admit that the NFS client doesn't seem to know, 
when the server was restart. The simpliest thing i can imagine, is that 
the NFS server generates a random integer-value at start, and transmits 
it along with ESTALE. If the integer-value is different from the 
integer-value the server send while mounting the FS, than the kernel has 
to remount it transparently. This is a simple thing so that a client can 
safely determine, if the server has been restarted, or not, and it only 
adds 4 byte to some nfs-packets.

> Reopening the file, and then continuing to write from the same position
> may be the right thing to do, but then again it may cause you to
> overwrite a bunch of freshly written password entries.

In my case, if the nfs directory is mounted to /mnt/nfs, i can't even do 
a simple "cd /mnt/nfs" without getting the "stale nfs handle" - even if 
i use a different shell. I always thought, that the "cd /mnt/nfs" should 
work, since the shell will aquire a new handle, but it doesn't work :-(

So i'm not really talking about restoring all file-handles. The 
filehandles that were still open while the server restarted may stay 
broken, but i'd like to be abled to open new ones at last.

> So we bounce the error up to userland where these issues can actually be
> resolved.

This is a good thing to do in general, but i think this needs improvement.

