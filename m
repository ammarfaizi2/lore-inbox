Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUFDRhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUFDRhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUFDRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:33:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:38858 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265898AbUFDRak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:30:40 -0400
Date: Fri, 4 Jun 2004 19:30:15 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: arjanv@redhat.com, torvalds@osdl.org, luto@myrealbox.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
 2.6.7-rc2-bk2
Message-Id: <20040604193015.2cdad953.ak@suse.de>
In-Reply-To: <20040604164032.GA2331@infradead.org>
References: <20040603230834.GF868@wotan.suse.de>
	<20040604092552.GA11034@elte.hu>
	<200406040826.15427.luto@myrealbox.com>
	<Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
	<20040604154142.GF16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
	<20040604155138.GG16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
	<20040604181304.325000cb.ak@suse.de>
	<20040604163753.GN16897@devserv.devel.redhat.com>
	<20040604164032.GA2331@infradead.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 17:40:32 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Jun 04, 2004 at 06:37:54PM +0200, Arjan van de Ven wrote:
> > Fedora makes the heap non executable too; it only broke X which has it's own
> > shared library loader (which btw had all the right mprotects in place, just
> > ifdef'd for freebsd, ia64 and a few other architectures that default to
> > non-executable heap, so we just added x86(-64) to that)
> 
> Maybe you should just call mprotect always to be safe? :)  OTOH I guess
> the world would end if a X release had less ifdefs than the previous one..

If you do that please also fix the X server to always use the /proc/bus/pci/* 
access methods too instead of banging on  0xcf8 directly. The current
method is racing with the kernel and can actually cause hard disk corruption
on x86-64 machines that use the IOMMU (IOMMU flush uses pci config space
access too) 

-Andi
