Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTLJHDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 02:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTLJHDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 02:03:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:25316 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262686AbTLJHDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 02:03:37 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: dan carpenter <error27@email.com>, Bart Samwel <bart@samwel.tk>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-scsi scheduling while atomic in linux-2.6.0-test11
Date: Wed, 10 Dec 2003 08:03:29 +0100
User-Agent: KMail/1.5.4
References: <3FD6AF84.5010805@samwel.tk> <200312092120.18367.error27@email.com>
In-Reply-To: <200312092120.18367.error27@email.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312100803.29578.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan carpenter wrote:
> > ide-scsi scheduling while atomic in linux-2.6.0-test11
>
> You don't need ide-cd to burn cds in 2.6 so the easiest fix is to just
> stop using ide-cd.  Anyway,  here is the buggy code that causes the
> problem:

ide-scsi....ide-cd is working.
>
> drivers/scsi/ide-scsi.c
> 895:         spin_lock_irqsave(&ide_lock, flags);
> 896:         while (HWGROUP(drive)->handler) {
> 897:                 HWGROUP(drive)->handler = NULL;
> 898:                 schedule_timeout(1);
> 899:         }
>
> The fix is quite complicated and I don't know how to do it correctly.  :/

First idea I have is to replace the spinlocks with semaphores. 

cheers

CHristian

