Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032125AbWLGMd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032125AbWLGMd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032129AbWLGMd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:33:26 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:43960 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032125AbWLGMdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:33:25 -0500
Date: Thu, 7 Dec 2006 12:33:21 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [MIPS] Import updates from i386's i8259.c
Message-ID: <20061207123321.GB15386@linux-mips.org>
References: <S20037871AbWLFUPw/20061206201552Z+14601@ftp.linux-mips.org> <20061207094639.GA30260@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207094639.GA30260@lst.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 10:46:39AM +0100, Christoph Hellwig wrote:

> On Wed, Dec 06, 2006 at 08:15:47PM +0000, linux-mips@linux-mips.org wrote:
> > Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp> Thu Dec 7 02:04:17 2006 +0900
> > Comitter: Ralf Baechle <ralf@linux-mips.org> Wed Dec 6 20:10:54 2006 +0000
> > Commit: bf8cfe1360932f191a3ea8d47c773c008ec32cd7
> > Gitweb: http://www.linux-mips.org/g/linux/bf8cfe13
> > Branch: master
> > 
> > Import many updates from i386's i8259.c, especially genirq transitions.
> 
> Shouldn't we try to share i8259.c over the various architectures that
> use this controller?  With the generic hardirq framework that should be
> possible.

See http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20061206203259.GA10170%40linux-mips.org ;-)

The MIPS version of i8259 is already sharable that is all the code that
doesn't immediately deal with the i8259 PIC has been removed.  A few
small things will need still need attention.  i386 uses this silly
optimization in cached_master_mask / cached_slave_mask that depends on
little endian byte order.  i386 programs ICW2 with 0x20 while MIPS uses
I8259A_IRQ_BASE.  And the i386 version has various stuff such as the FPU
interrupt handler which are not immediately i8259A-related in i8259.c.

  Ralf
