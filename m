Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbTKMOzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 09:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTKMOzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 09:55:36 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:24591
	"EHLO eumucln02.muc.eu.mscsoftware.com") by vger.kernel.org with ESMTP
	id S264306AbTKMOzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 09:55:33 -0500
In-Reply-To: <Pine.LNX.4.53.0311130927280.30784@chaos>
Subject: Re: nfs_statfs: statfs error = 116
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF8497F0B5.C94E6443-ONC1256DDD.0051048E-C1256DDD.0051C1A9@mscsoftware.com>
From: Martin.Knoblauch@mscsoftware.com
Date: Thu, 13 Nov 2003 15:52:59 +0100
X-MIMETrack: Serialize by Router on EUMUCLN02/MSCsoftware(Release 6.0.2CF1|June 9, 2003) at
 11/13/2003 03:56:18 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





"Richard B. Johnson" <root@chaos.analogic.com> wrote on 11/13/2003 03:39:53
PM:

> On Thu, 13 Nov 2003, martin.knoblauch  wrote:
>
> > Hi,
> >
> >   sorry if OT, but what is above message trying to tell me? Where can I
> > find a translation of the numbers? We are seeing 116 very frequently,
> > 512 and 5 on occasion.
> >
>
> ESTALE is "errno" 116
> EIO  is "errno" 5
> ERESTARTSYS is "errno" 512
>
> You can find these in /usr/include/asm/errno.h (not good to
> directly include in a program).
>
> The program reporting these errors should have included:
>
> <errno.h>
> <string.h>
>

 The messages actually come out of the kernel-nfs code (inode.c). Should
have mentioned "dmesg" :-)

> Then used...
>    strerror(errno);
> or
>    perror("");
> etc.
>
>
> Errno 512 should never be seen by user-mode program, so the
> header file, /usr/include/linux/errno.h, states...
>

 This worries me a bit :-)

> ESTALE happens when a mounted file-system is on a server that
> went down or re-booted. The file-handles are then "stale".
>

 I am "alomost" sure that there were no reboot or failover events at the
time of most of the stale messages. But I'm not going to lay my hand on the
book for that.

> EIO is a general catch-all for an I/O error.
>
> ERESTARTSYS is the error returned by a server that has
> re-booted that is supposed to tell the client-side software
> to get a new file-handle because of an attempt to access with
> a stale file-handle. When getting this error, the client
> should have reopened the file(s) to obtain a new handle.
>

 Definitely no server reboot or HA Failover at the time of the messages.

Thanks
Martin

