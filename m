Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWC3LKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWC3LKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWC3LKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:10:30 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59332 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932174AbWC3LK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:10:29 -0500
Subject: Re: IDE CDROM tail read errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <m3wtedrrpf.fsf@defiant.localdomain>
References: <m3wtedrrpf.fsf@defiant.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Mar 2006 12:18:09 +0100
Message-Id: <1143717489.29388.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-29 at 21:11 +0200, Krzysztof Halasa wrote:
> # ls -l
> -rw-r--r-- 1 root root 687177728 Mar 29 15:51 img-15.iso
> -rw-r--r-- 1 root root 687177728 Mar 29 15:58 img-15a.iso
> 
> The files are just truncated FC5d1 images (57344 bytes missing).

The final partial read is dropped rather than partially completed.

> # cat /sys/block/sr0/size
> 1342264 (i.e., the same as with 2.6.15 + drivers/ide)
> 
> # cat /dev/cdrw > img-16a.iso
> cat: /dev/cdrw: Input/output error
> 
> # cat /sys/block/sr0/size
> 1342256 (looks like it has been adjusted to .iso image size / 512 when
>          the first I/O error occured)

The SCSI layer does this bit for everyone. Its actually not libata or
the PATA drivers that have done the work here. You should find ide-scsi
does the same.

I patched the old IDE driver a bit to try and deal with this and if you
want the patch to hack on and tidy up further feel free. 


