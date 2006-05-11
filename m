Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWEKQ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWEKQ7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWEKQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:59:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31412 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030357AbWEKQ7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:59:14 -0400
Subject: Re: [PATCH] make kernel ignore bogus partitions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, aeb@cwi.nl
In-Reply-To: <20060511092736.27cedfd5.akpm@osdl.org>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
	 <20060509124138.43e4bac0.akpm@osdl.org>
	 <20060511161736.GB8124@beardog.cca.cpqcorp.net>
	 <20060511092736.27cedfd5.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 18:09:04 +0100
Message-Id: <1147367344.26130.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 09:27 -0700, Andrew Morton wrote:
> "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
> >
> > On Tue, May 09, 2006 at 12:41:38PM -0700, Andrew Morton wrote:
> > > "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
> > > >
> > > > Patch 1/1
> > > > Sometimes partitions claim to be larger than the reported capacity of a
> > > > disk device. This patch makes the kernel ignore those partitions.

The problem with ignoring such partitions is that you will then get
burned on some PC setups and also that existing partitions may move
number on some partitioning schemes.

Allocating them but setting the reported size to zero would cure the
latter problem, but I'm not sure what the right thing to do is about
extended partition tables that look like this

0 Partition Table
  Bootblock
  ...
  Extended Partition to disk end
  Partition
HPA-------------------------- (reported disk size)
  Suspend partition
  BIOS bits
disk end -----

ie /dev/hda5 might be valid but not /dev/hda4 which contains it...

