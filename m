Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUHaBvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUHaBvd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHaBvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:51:33 -0400
Received: from launch.server101.com ([216.218.196.178]:50571 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S266196AbUHaBvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:51:31 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: K3b and 2.6.9?
Date: Tue, 31 Aug 2004 11:51:25 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408301047.06780.tim@bcs4me.com> <1093871277.30082.7.camel@localhost.localdomain>
In-Reply-To: <1093871277.30082.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408311151.25854.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 Aug 2004 23:07, Alan Cox wrote:

> Folks are working on getting the verify_command list refined, or you
> can run the burner part of cd-burners setuid (as cdrecord supports -
> although get the newest one since there was a security hole fixed a few
> days ago in both cdrecord and star).
>
> > Without knowing a better way, I am currently using the same sort of quick
> > patch as 2.6.8.1 to use k3b on 2.6.9-rc1-bk5 ie:
>
> Providing you don't mind any of your users erasing your drive firmware
> and turning the drive into a brick its fine.

Thanks. Yes I realize that and understand why this is a good idea to have. But 
most of the verify_command list seems fine and I find the following works, 
but don't know if this is any 'safer' or not... This is the particular test 
that makes the difference to k3b/cdrecord, but I don't know enough to work 
out what it actually does... (this is with 2.6.9-rc1-bk6) 

--- a/drivers/block/scsi_ioctl.c.original  2004-08-30 23:50:16.000000000 +1000
+++ b/drivers/block/scsi_ioctl.c  2004-08-31 08:37:56.000000000 +1000
@@ -192,7 +192,7 @@

        /* Write-safe commands just require a writable open.. */
        if (type & CMD_WRITE_SAFE) {
-               if (file->f_mode & FMODE_WRITE)
+/*              if (file->f_mode & FMODE_WRITE)      */
                        return 0;
        }
