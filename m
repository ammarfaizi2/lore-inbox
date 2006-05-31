Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbWEaWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWEaWoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWEaWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:44:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965221AbWEaWoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:44:15 -0400
Date: Wed, 31 May 2006 15:46:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: earny@net4u.de
Cc: list-lkml@net4u.de, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: ALPHA 2.6.17-rc5 AIC7###: does not boot
Message-Id: <20060531154648.53539006.akpm@osdl.org>
In-Reply-To: <200605301834.19795.list-lkml@net4u.de>
References: <200605301834.19795.list-lkml@net4u.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernst Herzberg <list-lkml@net4u.de> wrote:
>
> moinmoin.
> 
> 2.6.16.18 boots and runs without problems.
> 
> 2.6.17-rc5 with patch
> "[PATCH] alpha: generic hweight (Re: ALPHA 2.6.17-rc5 compile error)"
> http://www.ussg.iu.edu/hypermail/linux/kernel/0605.3/1559.html
> 
> hangs with 
> 
> [....]
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
>         <Adaptec aic7895 Ultra SCSI adapter>
>         aic7895C: Ultra Wide Channel B, SCSI Id=7, 32/253 SCBs
> 
>  1:0:0:0: Attempting to queue an ABORT message
> CDB:CDB: 0x12 0x12 0x0 0x0 0x0 0x0 0x0 0x0 0x24 0x24 0x0 0x0
>  1:0:0:0: Command already completed
> aic7xxx_abort returns 0x2002
>  1:0:0:0: Attempting to queue an ABORT message
> CDB: 0x12 0x0 0x0 0x0 0x24 0x0
>  1:0:0:0: Command already completed
> aic7xxx_abort returns 0x2002
> [....]
> 
> dmesg (captured with netconsole and netcat, most messages are duplicated
> but better than nothing)
>
> ...
>

James sayeth "Best guess would be lost interrupt ...  especially if there's
no device usually at target1:0:0 (i.e.  the machine doesn't get a reply it
expects doing the initial inquiry)."

But I don't recall us making any changes in the Alpha interrupt-management
code post-2.6.16.  Perhaps it was PCI changes which introduced this
regression.

