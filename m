Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUIECXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUIECXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUIECXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:23:17 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:44228 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S265973AbUIECXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:23:14 -0400
Message-ID: <413A789C.9000501@upb.de>
Date: Sun, 05 Sep 2004 04:23:24 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: why do i get "Stale NFS file handle" for hours?
References: <chdp06$e56$1@sea.gmane.org>	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de> <1094349744.13791.128.camel@lade.trondhjem.org>
In-Reply-To: <1094349744.13791.128.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.275,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-MailScanner-From: skoehler@upb.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I agree, but you simply admit that the NFS client doesn't seem to know, 
>>when the server was restart. The simpliest thing i can imagine, is that 
>>the NFS server generates a random integer-value at start, and transmits 
>>it along with ESTALE. If the integer-value is different from the 
>>integer-value the server send while mounting the FS, than the kernel has 
>>to remount it transparently. This is a simple thing so that a client can 
>>safely determine, if the server has been restarted, or not, and it only 
>>adds 4 byte to some nfs-packets.
> 
> No.... The simplest thing is for the server to actually abide by the
> RFCs and not generate filehandles that change on reboot.

OK, that sounds complicated, but if it would work, than it would be very 
nice indeed.

> NFSv4 is the ONLY version of the protocol that actually supports the
> concept of filehandles that have a finite lifetime.

But NFSv4 is still exprerimental :-( and i think the client don't have 
NFSv4 support too.

>>In my case, if the nfs directory is mounted to /mnt/nfs, i can't even do 
>>a simple "cd /mnt/nfs" without getting the "stale nfs handle" - even if 
>>i use a different shell. I always thought, that the "cd /mnt/nfs" should 
>>work, since the shell will aquire a new handle, but it doesn't work :-(
> 
> It won't if the root filehandle is broken too. That is the standard way
> of telling the NFS client that the administrator has revoked our access
> to the filesystem.
> 
> The solution is simple here: fix the broken server...

Sorry? Why is my server broken? I'm using kernel 2.6.8.1 with nfs-utils 
1.0.6 on my server, and i don't see, what should be broken.

Thx
   Sven
