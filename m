Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUGETMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUGETMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUGETMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:12:08 -0400
Received: from mail.shareable.org ([81.29.64.88]:62639 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261638AbUGETME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:12:04 -0400
Date: Mon, 5 Jul 2004 20:11:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on PPC and PPC64
Message-ID: <20040705191158.GA4457@mail.shareable.org>
References: <20040630031821.GB25149@mail.shareable.org> <20040705072731.GB19707@iram.es> <20040705142046.GB3411@mail.shareable.org> <20040705155908.GA23163@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705155908.GA23163@iram.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Gabriel Paubert tells me that PROT_NONE _might_ have the bug described
below on the PPC 4xx and 8xx architectures, because their MMUs don't
implement "Ks = Kp = 1" segments.

Can you or someone else confirm whether the potential bug occurs on
PPC 4xx/8xx?

Thanks,
-- Jamie

Paul Mackerras wrote:
> > It appears the only difference betwen PROT_READ and PROT_NONE is
> > whether _PAGE_USER is set.
> > 
> > Thus PROT_NONE pages aren't readable from userspace, but it appears
> > they _are_ readable from kernel space.  Is this correct?
> 
> No.  Kernel accesses to pages in the user portion of the address space
> (0 .. TASK_SIZE-1) are done using the user permissions.  On classic
> PPC this is implemented (in part) by setting Ks = Kp = 1 in the
> segment descriptors for the user segments, which tells the hardware to
> check the access as if it was a user access even in supervisor mode.
