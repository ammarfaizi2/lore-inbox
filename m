Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSDSPkp>; Fri, 19 Apr 2002 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312579AbSDSPko>; Fri, 19 Apr 2002 11:40:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37647 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312529AbSDSPkn>; Fri, 19 Apr 2002 11:40:43 -0400
Subject: Re: Bio pool & scsi scatter gather pool usage
To: lord@sgi.com (Steve Lord)
Date: Fri, 19 Apr 2002 16:57:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        peloquin@us.ibm.com (Mark Peloquin),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <1019230042.10294.285.camel@jen.americas.sgi.com> from "Steve Lord" at Apr 19, 2002 10:27:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yalh-0007JG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just looking at how my disks ended up partitioned not many of them are
> even on 4K boundaries, so any sort of concat built on them would
> have a boundary case which required such a split - I think, still
> working on my caffine intake this morning.

Alignment and concatenation are different things altogether. On the whole I
can blast 64K chunks on a 512 byte alignment out of my controllers. The
partitioning doesn't bother me too much. Do we even want to consider a
device that cannot hit its own sector size boundary ?

Oh and the unusual block size stuff seems to be quite easy for the bottom
layers. The horror lurks up higher. Most file systems can't cope (doesn't
matter too much), isofs can be mixed block size (bletch) but the killer
seems to be how you mmap a file on a device with 2326 byte sectors sanely..
(Just say no ?)
