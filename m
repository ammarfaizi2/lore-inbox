Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVAOCyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVAOCyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVAOCyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:54:41 -0500
Received: from hera.kernel.org ([209.128.68.125]:54951 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262167AbVAOCyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:54:35 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: chasing the four level page table
Date: Sat, 15 Jan 2005 02:54:15 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <csa0kn$4eg$1@terminus.zytor.com>
References: <9e47339105010609175dabc381@mail.gmail.com> <9e4733910501061205354c9508@mail.gmail.com> <20050106214159.GG16373@redhat.com> <9e47339105010721225c0cfb32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1105757655 4561 127.0.0.1 (15 Jan 2005 02:54:15 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 15 Jan 2005 02:54:15 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9e47339105010721225c0cfb32@mail.gmail.com>
By author:    Jon Smirl <jonsmirl@gmail.com>
In newsgroup: linux.dev.kernel
>
> On Thu, 6 Jan 2005 16:41:59 -0500, Dave Jones <davej@redhat.com> wrote:
> > No other device driver is also doing such lowlevel stuff with
> > page tables directly afaics. drivers/char/drm seem to be the only drivers
> > using [pgd|pmd|pte]_offset() routines.
> 
> On 6 Jan 2005 20:38:27 +0100, Andi Kleen <ak@muc.de> wrote:
> > Perhaps we should add a get_user_phys() or somesuch for this.
> 
> I think this is a case where the memory manager is missing a function
> that DRM needs. If there was a get_user_phys() function DRM wouldn't
> need to walk the page tables.
> 

FWIW, the Nvidia device driver wrapper also has this issue.

There seems to be at least two classes of device drivers -- graphics
and RDMA -- which have a genuine need to DMA user pages, after
appropriate locking, of course.

At that point we're better off having the mm export the right
functionality to keep device driver authors from doing it wrong.

	-hpa
