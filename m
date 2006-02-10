Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWBJTay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWBJTay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWBJTax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:30:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751319AbWBJTaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:30:52 -0500
Date: Fri, 10 Feb 2006 11:29:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: bernd-schubert@gmx.de
Cc: bernd.schubert@pci.uni-heidelberg.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: a couple of oopses with 2.6.14
Message-Id: <20060210112958.025a7bfb.akpm@osdl.org>
In-Reply-To: <200602101924.45467.bernd.schubert@pci.uni-heidelberg.de>
References: <200602091934.20732.bernd.schubert@pci.uni-heidelberg.de>
	<20060209152744.00de43f6.akpm@osdl.org>
	<200602101924.45467.bernd.schubert@pci.uni-heidelberg.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de> wrote:
>
> > Can you test 2.6.15?
> 
> Yes, 2.6.15.3 works, no oopses.

Some progress.

> Only this information 
> 
> [4294743.341000] scsi0 : ata_piix
> [4294743.514000] ATA: abnormal status 0x7F on port 0xE407
> 
> I can't test if sata works, there's just nothing connected.

Has this machine's sata support ever worked?  If so, in which kernel? 
(Apologies if you've already described this).

> Btw, the printk timing information seem to be uninitalized, is this by 
> intentention or is it a bug?

It's expected.  We use a very raw, low-level funtion for the printk
timestamping because we don't want to be taking locks from within printk. 
The timestamping is mainly for working out the time duration between
printk's, rather than for absolute time.

