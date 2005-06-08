Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVFHI6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVFHI6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 04:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVFHI6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 04:58:16 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:446 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262142AbVFHI6J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 04:58:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pekb8dBU27ekn+NOdRNjVqWHP6i57FA/1VlsYZyGFSYUNfd8t/BZCdI22YkXY8H9UTL/+DDngx+Ovi6Ie8xyObw2SjZY7jGX/fiRv1UgXBeR/xndYiQHS9l8LG250Dr2TbbnvRKJ6hVTHlUeMpnNTZM7k7e+5nV+hingmit3nCs=
Message-ID: <58cb370e05060801585b49020e@mail.gmail.com>
Date: Wed, 8 Jun 2005 10:58:09 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: info@a-wing.co.uk
Subject: Re: sis5513.c patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42A6AB1B.8000800@a-wing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42A621BC.7040607@a-wing.co.uk>
	 <58cb370e05060800276f3fc29c@mail.gmail.com>
	 <42A6AB1B.8000800@a-wing.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> >
> >>Hi,
> >
> >
> > Hi,
> >
> 
> Hi again,
> 
> >
> >>I'm not sure if a similar patch has been submitted or not, but here is a
> >>patch to get DMA working on ASUS K8S-MX with a SiS 760GX/SiS 965L
> >>chipset combo.
> >
> >
> > This patch is incorrect, it adds PCI ID of SiS IDE controller (this ID
> > is common for almost all SiS IDE controllers and is already present in
> > sis5513_pci_tbl[]) to the table of SiS Host PCI IDs.  As a result driver
> > will try to use ATA_133 on all _unknown_ IDE controllers.  You need
> > to add PCI ID of the Host chipset (lspci should reveal it) instead.
> 
> Unless I am reading the following wrong 5513 is the PCI ID:

It is PCI ID of the IDE interface but you need PCI ID of the North Bridge.
The thing is that SiS is using the same PCI ID for all IDE controllers and
driver shouldn't be unconditionally programming all unknown/future SiS 
IDE controllers as they may differ from the current ones.

> 00:02.5 Class 0101: 1039:5513 (rev 01) (prog-if 80 [Master])
>         Subsystem: 1043:8139
>         Flags: bus master, medium devsel, latency 128
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at ffa0 [size=16]
>         Capabilities: [58] Power Management version 2

Could you please send full lspci -vvv output?

> >
> > Thanks,
> > Bartlomiej
> 
> Regards
> Andrew
> --
> Andrew Hutchings (A-Wing)
> Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
> Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
> BOFH excuse 424: operation failed because: there is no message for this
> error (#1014)
>
