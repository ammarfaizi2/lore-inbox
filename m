Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUFVHzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUFVHzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 03:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUFVHzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 03:55:06 -0400
Received: from gw.compusonic.fi ([195.255.196.126]:49375 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S261162AbUFVHyx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 03:54:53 -0400
Date: Tue, 22 Jun 2004 10:54:52 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Andrea Arcangeli <andrea@suse.de>
Cc: 4Front Technologies <dev@opensound.com>,
       David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <20040622020615.GE14478@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0406221033350.8222@zeus.compusonic.fi>
References: <40D232AD.4020708@opensound.com> <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi>
 <Pine.LNX.4.60.0406201506360.6470@dlang.diginsite.com> <40D636EA.7090704@opensound.com>
 <20040622020615.GE14478@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Andrea Arcangeli wrote:

> To make the last recent example we had to break the source API with the
> drivers to fix the release_pages race that Andrew found and fixed in
> mainline too. That changes page->count into page->_count and quite some
> drivers broke even outside the kernel. I had the choice of not breaking
> the API but that would had forced us to disable irq and take a per-zone
> spinlock in every last put_page(), definitely not desiderable in a
> enterprise OS where number matters. I appreciate the ability to fix
> things right and to boost performance to the maximum whenever possible,
> like it happens in the mainline kernel tree. I even had a lengthy
> private discussion with Andrew and it was him suggesting me the
> local_irq_disable + atomic_dec_and_lock as the only possible
> alternative, but it wasn't attractive enough for performance reasons.
> Furthermore in a few years people would be more annoyed by page->count
> than by page->_count as people moves into more recent mainline releases.
This kind of "breaks" are not so fatal provided that there is some way to
detect them reliably. Usually it's possible to check LINUX_VERSION_CODE
and use different approaches depending on the kernel version. However
this doesn't always work because distribution vendors often back port
features from the newer kernels into their distribution kernels which
have older LINUX_VERSION_CODE. A better  approach would be marking them
with #define HAVE_NEW_something in the header file that implements this
change.

In the long term frequent changes in kernel interfaces cause problems
because drivers that try to stay compatible with as many kernel versions
as possible will start looking like #ifdef spaghetti.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
