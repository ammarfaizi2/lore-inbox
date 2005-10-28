Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVJ1GxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVJ1GxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbVJ1GxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:53:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:64230 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965113AbVJ1GxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:53:19 -0400
Date: Fri, 28 Oct 2005 08:48:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: hooanon05@yahoo.co.jp, Unionfs mailing list <unionfs@fsl.cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS Permission denied instead of EROFS
In-Reply-To: <1130453668.23138.12.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.61.0510280843340.6910@yvahk01.tjqt.qr>
References: <E1EVAnp-0000p1-Tq@jroun>  <Pine.LNX.4.61.0510272236230.13626@yvahk01.tjqt.qr>
 <1130453668.23138.12.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> # mount localhost:/export /mnt -t nfs -oro
>
>This is on a filesystem that has been mounted with the -ro flag? That
>would be a client bug.

I seem to mix things up too often. Smaller and correct:

-o rw for ro-exported-fs returns EACCES instead of EROFS for write 
operations on files that exist.

>Hmm... The client code does look a bit dodgy there (particularly NFSv4).
>I'll see if I can come up with a patch.

I use nfsv3...

>> Which brings me right to question... should mountd or knfsd be adjusted to
>> refuse a rw mount request if an nfs export is only available as ro? Like it is
>> already the case with normal block devices:
>
>How would knfsd or mountd know? There is no way for the client to
>communicate to the server that it is mounting for read-write.

What, the client does not pass the ro/rw flag along? Humm.

But knfsd knows that a certain export is ro, and therefore should return EROFS
for all write operations that it receives.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
