Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUJ3KXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUJ3KXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 06:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbUJ3KXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 06:23:34 -0400
Received: from main.gmane.org ([80.91.229.2]:13727 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263679AbUJ3KXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 06:23:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: k 2.6.9: ub module causes /dev/sda and /dev/sda1 not being created
Date: Sat, 30 Oct 2004 10:23:28 +0000 (UTC)
Message-ID: <slrnco6qt0.v5k.psavo@varg.dyndns.org>
References: <4182FA3D.1090108@esoterica.pt>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paulo da Silva <psdasilva@esoterica.pt>:
> I had problems with my pen drive.
> Module ub (autolodaded) recognized the pendrive. So /dev/sda
> and /dev/sda1 didn't get created. After removing ub module
> from kernel config I could mount the pen drive as /dev/sda1.

Yes, that bit me with CF card reader too. AFAICS The Right Solution is
to create /dev/ub -devices and use them.

Following worked for me:
- -
mknod /dev/uba b 125 0
mknod /dev/uba1 b 125 1
mknod /dev/uba2 b 125 2
mknod /dev/ubb b 125 8
mknod /dev/ubb1 b 125 9
mknod /dev/ubb2 b 125 10
mknod /dev/ubc b 125 16
mknod /dev/ubc1 b 125 17
mknod /dev/ubc2 b 125 18
- -

/dev/sda1 becomes /dev/uba1 etc.

There is a notion that 125 -major number will be going away?:
<https://lists.one-eyed-alien.net/pipermail/usb-storage/2004-August/000709.html>


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

