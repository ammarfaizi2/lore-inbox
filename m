Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTKNOZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKNOZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:25:13 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:58642
	"EHLO eumucln02.muc.eu.mscsoftware.com") by vger.kernel.org with ESMTP
	id S262686AbTKNOYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:24:41 -0500
In-Reply-To: <16308.56683.38537.801595@charged.uio.no>
Subject: Re: nfs_statfs: statfs error = 116
To: trond.myklebust@fys.uio.no
Cc: Linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF146490DE.A5F7DDE9-ONC1256DDE.004E922A-C1256DDE.004EF6B8@mscsoftware.com>
From: Martin.Knoblauch@mscsoftware.com
Date: Fri, 14 Nov 2003 15:22:29 +0100
X-MIMETrack: Serialize by Router on EUMUCLN02/MSCsoftware(Release 6.0.2CF1|June 9, 2003) at
 11/14/2003 03:25:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Trond Myklebust <trond.myklebust@fys.uio.no> wrote on 11/14/2003 02:49:31
PM:

> >>>>> " " == Martin Knoblauch <Martin.Knoblauch@mscsoftware.com> writes:
>
>      > I accidentally run iozone on two clients with the output file
>      > being the same and residing on the NFS Server. Pure luser
>      > error, but it produced ESTALE pretty much reproducibly.
>
> Sure. This is a prime example of where ESTALE *is* appropriate. One
> NFS client is deleting a file on the server while the other is still
> using it.
>
> In the NFSv2/v3 protocols, the assumption is that filehandles are
> valid for the entire lifetime of the file on the server. IOW only
> "unlink()" can cause a valid filehandle to become stale. This is
> mainly because there is no notion of open()/close(), so the server
> would never be capable of determining when your client has stopped
> using the filehandle.
>
> If your 2 processes were running on the same machine, you would have
> seen the kernel temporarily rename your file to .nfsXXXXXX in order to
> work around the above problem. Delete that file, and you will generate
> ESTALE reproducibly too....
>
> Cheers,
>   Trond
Trond,

 cool. Great explanation. Always good if you can get those that know into
talking :-)

Cheers
Martin

