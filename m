Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVAOEY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVAOEY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVAOEY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:24:57 -0500
Received: from one.firstfloor.org ([213.235.205.2]:43461 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262096AbVAOEY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:24:56 -0500
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: chasing the four level page table
References: <9e47339105010609175dabc381@mail.gmail.com>
	<9e4733910501061205354c9508@mail.gmail.com>
	<20050106214159.GG16373@redhat.com>
	<9e47339105010721225c0cfb32@mail.gmail.com>
	<csa0kn$4eg$1@terminus.zytor.com>
From: Andi Kleen <ak@muc.de>
Date: Sat, 15 Jan 2005 05:24:54 +0100
In-Reply-To: <csa0kn$4eg$1@terminus.zytor.com> (H. Peter Anvin's message of
 "Sat, 15 Jan 2005 02:54:15 +0000 (UTC)")
Message-ID: <m1brbrwc89.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin) writes:
>
> There seems to be at least two classes of device drivers -- graphics
> and RDMA -- which have a genuine need to DMA user pages, after
> appropriate locking, of course.

And block devices with O_DIRECT and network devices. We supported that
fine for years with get_user_pages.

The issue with DRM is just that it does something more different:

it wants to get at a AGP page outside get_user_pages doesn't work for
this because the AGP hole is often outside mem_map. For that a 
nice helper is missing.

I'm not 100% we really want a helper because it's rather obscure
requirement, unlikely to be useful for others, and it may be better 
to keep it in DRM.

-Andi
