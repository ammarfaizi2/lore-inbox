Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWBWM3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWBWM3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWBWM3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:29:04 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:19636 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751112AbWBWM3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:29:02 -0500
To: Arjan van de Ven <arjan@intel.linux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [Patch 1/3] prefetch the mmap_sem in the fault path
References: <1140686152.2972.25.camel@laptopd505.fenrus.org>
	<1140687007.4672.6.camel@laptopd505.fenrus.org>
From: Jes Sorensen <jes@sgi.com>
Date: 23 Feb 2006 07:29:00 -0500
In-Reply-To: <1140687007.4672.6.camel@laptopd505.fenrus.org>
Message-ID: <yq0zmkigsxf.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Arjan" == Arjan van de Ven <arjan@intel.linux.com> writes:

Arjan> In a micro-benchmark that stresses the pagefault path, the
Arjan> down_read_trylock on the mmap_sem showed up quite high on the
Arjan> profile. Turns out this lock is bouncing between cpus quite a
Arjan> bit and thus is cache-cold a lot. This patch prefetches the
Arjan> lock (for write) as early as possible (and before some other
Arjan> somewhat expensive operations). With this patch, the
Arjan> down_read_trylock basically fell out of the top of profile.

Out of curiousity, how big was the box used for testing? It might be
worth investigating if anything can be done to reduce the number of
times that lock is taken in the first place.

After all, what's a pain on a 4-way tends to be an utter nightmare on
a 16-way ;(

Cheers,
Jes
