Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbULCOqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbULCOqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 09:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbULCOqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 09:46:11 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:22672 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262210AbULCOqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 09:46:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dmWusMNxj6G6tn8MVNZ2cMY3zJzuoHJp6Bt78BHpmG/vgX0xI4yyoq3fwZZ+8la7hMM8ql1Tq+daECcYCqdT/z1R+tdzc1BoNI3mm9gIZDqxyXiTxL79ryvJx+MDbyTjGXbo4J1BS9H8+8jQ4eLS++oJSc+tDXBnAKvi26sWLV8=
Message-ID: <3b2b32004120306463b016029@mail.gmail.com>
Date: Fri, 3 Dec 2004 09:46:00 -0500
From: Linh Dang <dang.linh@gmail.com>
Reply-To: Linh Dang <dang.linh@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16815.31634.698591.747661@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3b2b32004120206497a471367@mail.gmail.com>
	 <3b2b320041202082812ee4709@mail.gmail.com>
	 <16815.31634.698591.747661@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004 07:31:14 +1100, Paul Mackerras <paulus@samba.org> wrote:
> Linh Dang writes:
> 
> > In 2.6.9 on non-APUS ppc32 platforms, virt_to_bus() will just subtract
> > KERNELBASE  from the the virtual address. bus_to_virt() will perform
> > the reverse operation.
> >
> > This patch will make virt_to_bus():
> >
> >      - perform the current operation if the virtual address is between
> >        KERNELBASE and ioremap_bot.
> 
> Why do you want to do this?  The only code that should be using
> virt_to_bus or bus_to_virt is the DMA API code, and it's happy with
> them the way they are.

I wrote a DMA engine (to used by other drivers) that (would like to) accept
all kind of buffers as input (vmalloced, dual-access shared RAM mapped
by BATs, etc). The DMA engine has to decode the virtual address of the
input buffer to (possibly multiple) physical  address(es). virt_to_phys()
has the right name for the job except it only works for the kernel virtual
addresses initially mapped at KERNELBASE

> 
> > The patch also changes virt_to_phys()/phys_to_virt() in a similar way.
> 
> What do you want to use them for?  They are only for use in low-level
> memory management code.

Any driver for a DMA-capable device would use them and the way
virt_to_phys/phys_to_virt is currently written, you can't used them
with vmalloced buffers.

> 
> Paul.
> 
Thanx for the feedback
-- 
Linh Dang
