Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVLIULa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVLIULa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVLIULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:11:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65035 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932439AbVLIULa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:11:30 -0500
Date: Fri, 9 Dec 2005 21:11:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@ver.kernel.org, ak@suse.de
Subject: Re: [RFC] Introduce atomic_long_t
Message-ID: <20051209201127.GE23349@stusta.de>
References: <Pine.LNX.4.62.0512091053260.2656@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512091053260.2656@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 10:58:40AM -0800, Christoph Lameter wrote:

> Several counters already have the need to use 64 atomic variables on 64
> bit platforms (see mm_counter_t in sched.h). We have to do ugly ifdefs to
> fall back to 32 bit atomic on 32 bit platforms.
> 
> The VM statistics patch that I am working on will also need to make more 
> extensive use of 64 bit counters when available.
> 
> This patch introduces a new type atomic_long_t that works similar to the c
> "long" type. Its 32 bits on 32 bit platforms and 64 bits on 64 bit platforms.
> 
> The patch uses atomic_long_t to clean up the mess in include/linux/sched.h.
> Implementations for all arches provided but only tested on ia64.
>...

The idea looks good, but the amount of code duplication is ugly.

What about creating an include/linux/atomic.h [1] that contains both 
this new code and other common code like the atomic_t typedef (unless 
there's a good reason why counter isn't volatile on h8300 and v850...).

cu
Adrian

[1] include/asm-generic/atomic.h would be another solution, but for
    an API that should be available on all architectures, include/linux/
    seems to be the more logical place

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

