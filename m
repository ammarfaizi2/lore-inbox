Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTLOV4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTLOV4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:56:50 -0500
Received: from zero.aec.at ([193.170.194.10]:21514 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263904AbTLOV4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:56:49 -0500
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PCI Express support for 2.4 kernel
From: Andi Kleen <ak@muc.de>
Date: Mon, 15 Dec 2003 22:56:15 +0100
In-Reply-To: <137wc-q1-23@gated-at.bofh.it> (Vladimir Kondratiev's message
 of "Mon, 15 Dec 2003 21:30:24 +0100")
Message-ID: <m3fzflpwxs.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <12InT-wQ-5@gated-at.bofh.it> <135Nw-5gv-3@gated-at.bofh.it>
	<137wc-q1-23@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev <vladimir.kondratiev@intel.com> writes:
>
> As alternative between 1 page and 256M, I see also lazy allocation on
> per-bus basis: when bus is first accessed, ioremap 1Mb for it. On real
> system, it is no more then 3-4 buses. This way, we will end with
> several 1MB mappings. Finer granularity do not looks feasible, since
> bus scanning procedure tries to access all devices.

For bus scanning fixmaps are fine, but for the normal use of the
config space in the driver just doing ioremap once (e.g. at
pci_enable_device time) and caching it is preferable.  The number of
PCI-E devices in a given system should be bounded, so e.g. when you
have 100 devices you will only lose 400kB of vmalloc space this way
which is quite reasonable.

I don't think dynamic fixmaps at each access would be a good idea.

-Andi
