Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVJPAFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVJPAFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 20:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVJPAFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 20:05:41 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:3876 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751265AbVJPAFk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 20:05:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+fOsUkTZPi561n9L0X7cPfKW2HJ/H2MIAOQIt+vZjWze4/RxUcUig9zn/v9xDyUSZRLnwmhhd0oFbjqisbDmRIKgKpJaL9+0ntAChIJ+8WMn1ypEqiO6l4uVDc0JP7Rg1v+0SQEkAoYayvuBsxhmtR12aAjgcrGS0fO/roq+BQ=
Message-ID: <6bffcb0e0510151705l67725fd3t@mail.gmail.com>
Date: Sun, 16 Oct 2005 00:05:40 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: hdparm almost burned my SATA disk
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20051016010459.0c9a2beb@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051016010153.768d29d5@werewolf.able.es>
	 <20051016010459.0c9a2beb@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/10/05, J.A. Magallon <jamagallon@able.es> wrote:
> On Sun, 16 Oct 2005 01:01:53 +0200, "J.A. Magallon" <jamagallon@able.es> wrote:
>
> > Hi all...
> >
> > I have seen a very strange thing.
> > I was trying hdparm -tT on a SATA disk, it did the buffered part OK,
> > and hanged my box in the non-buffered measure. After waiting some minutes,
> > I did a SysRQ-s-u-b, and the the disk began to give many read errors on
> > sectors and could not boot because journal was not present and many other
> > errors.
> >
> > After some warm and cold boots, finally the box came up correctly.
> > I suspect that something that hdparm did left my disk dumb. But what ?
> > I will keep away from hdparm for some time...
> >
> > Any idea ?
> >
>
> Oops I forgot.
> Kernel is 2.6.14-rc2-mm2.
> hdparm is v6.1
> Filesystem is ext3 on a
>
> werewolf:~/soft/kernel/patches/2.6.13-jam8# hdparm -I /dev/sda
>
> /dev/sda:
>
> ATA device, with non-removable media
>         Model Number:       Maxtor 6L160M0
>         Serial Number:      L40MRV4G
>         Firmware Revision:  BANC1G10

debian:/home/michal# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   3652 MB in  2.00 seconds = 1823.54 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
 Timing buffered disk reads:  174 MB in  3.01 seconds =  57.72 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
debian:/home/michal# hdparm -V
hdparm v6.1
debian:/home/michal# hdparm -I /dev/sda

/dev/sda:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device

debian:/home/michal# uname -r
2.6.14-rc4-g7a3ca7d2

CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y

I have noticed the same behavior on 2.6.12.

Regards,
Michal Piotrowski
