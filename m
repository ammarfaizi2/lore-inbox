Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVGVUSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVGVUSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVGVUSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:18:00 -0400
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:63363 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262158AbVGVUQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:16:27 -0400
To: linux-kernel@vger.kernel.org
CC: Thomas Hood <jdthood@yahoo.co.uk>
Subject: Re: 2.6.13-rc3 dma_timer_expiry
References: <E1DvJrg-0000pG-AO@approximate.corpus.cam.ac.uk>
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 22 Jul 2005 16:16:07 -0400
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1Dw3wG-000129-2d@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d47826f234369f82662f983b476f727da1a52b9874851dc0fce7350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my previous message on this subject:

> With 2.6.13-rc3 I now get these errors (2.6.11.4 was fine) on my TP
> 600X (Debian 'etch' system):
> 
> localhost kernel: hda: dma_timer_expiry: dma status == 0x21
> localhost kernel: hda: DMA timeout error

> localhost kernel: hda: dma timeout error: status=0x58 { DriveReady
>     SeekComplete DataRequest }

I just narrowed the problem to an interaction with the tpctl tools.

If I turn off /etc/init.d/tpctl (turn its sysV symlinks into K* links),
I get no DMA errors.  I can then reproduce the errors by
       /etc/init.d/tpctl start
(which runs tpctl and loads the smapi and thinkpad modules), as long as
I am in runlevel 2 or higher.  If I'm in runlevel 1, I get no errors.

I'm using Debian's tpctl package (4.17-1).  With kernel 2.6.13-rc3, I'm
using the thinkpad modules from Debian's thinkpad-source (5.8-4)
package.  With 2.6.11.4 I use the 5.8-3 package for the source, but it's
almost the same as 5.8-4.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
