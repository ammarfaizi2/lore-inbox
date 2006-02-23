Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWBWJnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWBWJnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWBWJnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:43:00 -0500
Received: from mail.suse.de ([195.135.220.2]:37254 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751676AbWBWJm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:42:58 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@intel.linux.com>
Subject: Re: [Patch 1/3] prefetch the mmap_sem in the fault path
Date: Thu, 23 Feb 2006 10:39:35 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140686152.2972.25.camel@laptopd505.fenrus.org> <1140687007.4672.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1140687007.4672.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231039.36338.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 10:30, Arjan van de Ven wrote:
> In a micro-benchmark that stresses the pagefault path, the down_read_trylock
> on the mmap_sem showed up quite high on the profile. Turns out this lock is
> bouncing between cpus quite a bit and thus is cache-cold a lot. This patch
> prefetches the lock (for write) as early as possible (and before some other
> somewhat expensive operations). With this patch, the down_read_trylock
> basically fell out of the top of profile.

It is hard to believe because you effectively didn't do the prefetch
very early

(e.g. the patch from your prefetch to taking the lock is quite short) 

-Andi
