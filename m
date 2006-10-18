Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423143AbWJRXBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423143AbWJRXBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423144AbWJRXBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:01:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46470 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423138AbWJRXBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:01:18 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061018154402.ef49874a.akpm@osdl.org>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	 <45364CE9.7050002@yahoo.com.au>
	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	 <45366515.4050308@yahoo.com.au>
	 <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	 <20061018154402.ef49874a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 16:01:05 -0700
Message-Id: <1161212465.18117.35.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 15:44 -0700, Andrew Morton wrote:
> On Wed, 18 Oct 2006 10:58:23 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > > > No. seems to be generic issue .. (happens with ext3 also) :(
> > > 
> > > I think I may have missed a fix for ext3 ordered and journalled too
> > > (I've just sent a patch to Andrew privately).
> > > 
> > > Sorry. Can you try with ext2? Alternatively, try with ext3 or reiserfs
> > > and change the line in mm/filemap.c:generic_file_buffered_write from
> > > 
> > > 		status = a_ops->commit_write(file, page, offset, offset+copied);
> > > to
> > > 		status = a_ops->commit_write(file, page, offset, offset+bytes);
> > > 
> > > and see if that solves your problem (that will result in rubbish being
> > > temporarily visible, but there is a similar problem upstream anyway, so it
> > > shouldn't cause other failures in your test).
> > 
> > No. Above change didn't help either :(
> > 
> > Thanks,
> > Badari
> > 
> > BUG: soft lockup detected on CPU#1!
> 
> We should have got an all-CPU backtrace via the fancy new trigger_all_cpu_backtrace()
> thing.

Yes. Thought so..

> 
> Is the NMI watchdog ticking over?

I think so.

# dmesg | grep NMI
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
testing NMI watchdog ... OK.

Thanks,
Badari

