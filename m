Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWAFBUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWAFBUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWAFBUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:20:36 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:46653 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932368AbWAFBUf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:20:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jByhw8DWNUPXWxS05nlsUu3wq7rmYxMNgqJfb2ksz+tE3Zlo+GQoCPI5YPygfJiP23IAbVc5nzilZ6LU1eST6GTJnscYNlXJmSffsASOLRZvPZ/10qVRoPD8sRDnodv2Tiky5Tfwmy9icbePWi1xwp5H9g7fywR4URHIFlQhTuU=
Message-ID: <5a4c581d0601051720w73132c89j218864dd4e313427@mail.gmail.com>
Date: Fri, 6 Jan 2006 02:20:34 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: command line parsing broken in 2.6.15-git?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060105163922.7806343b@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105163922.7806343b@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> The command line parsing or psmouse driver is broken now, this
> makes my mouse go wacky on a KVM. It worked up until the latest
> git updates (post 2.6.15)
>
> Dmesg output:
>
> Kernel command line: root=/dev/md2 vga=0x31a ro selinux=0 psmouse.proto=bare
> Unknown boot option `psmouse.proto=bare': ignoring

Similar issue here... my DVD drive disappeared in 2.6.15-git1 because

Jan  5 17:15:12 sandman kernel: Kernel command line: ro root=/dev/sda6
libata.atapi_enabled=1 rhgb
Jan  5 17:15:12 sandman kernel: Unknown boot option
`libata.atapi_enabled=1': ignoring
[...]
Jan  5 17:15:15 sandman kernel: ata2: SATA max UDMA/133 cmd 0x170 ctl
0x376 bmdma 0xBFA8 irq 15
Jan  5 17:15:15 sandman kernel: ata2: dev 0 ATAPI, max UDMA/33
Jan  5 17:15:15 sandman kernel: ata2: dev 0 configured for UDMA/33
Jan  5 17:15:15 sandman kernel: scsi1 : ata_piix
Jan  5 17:15:15 sandman kernel: ata2(0): WARNING: ATAPI is disabled,
device ignored.


This works:

Jan  5 20:39:15 sandman kernel: Kernel command line: ro root=/dev/sda6
combined_mode=libata atapi_enabled=1 rhgb
[...]
Jan  5 20:39:20 sandman kernel: ata2: SATA max UDMA/133 cmd 0x170 ctl
0x376 bmdma 0xBFA8 irq 15
Jan  5 20:39:20 sandman kernel: ata2: dev 0 ATAPI, max UDMA/33
Jan  5 20:39:20 sandman kernel: ata2: dev 0 configured for UDMA/33
Jan  5 20:39:20 sandman kernel: scsi1 : ata_piix
Jan  5 20:39:20 sandman kernel:   Vendor: SONY      Model: DVD+-RW
DW-Q58A   Rev: UDS1
Jan  5 20:39:20 sandman kernel:   Type:   CD-ROM                      
      ANSI SCSI revision: 05


Seems in both cases the "module.option=value" syntax is broken,
 whereas the simple "option=value" works.

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
