Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422835AbWBIHAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWBIHAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 02:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWBIHAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 02:00:52 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:44460 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422835AbWBIHAv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 02:00:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g65M5LWHqLA27FdiUh+rprQCaLfgDxVSOsbxb3fyWIqop2OypGWXDMMHKvBI4wqMUeRnIsHAOepTSHCQ0KQ07syE8XrQVOuiBxVcdHA0ER7DvmL3qejwvK93lAM3lcLTSYdf3+erdbL+uZhvOJAFHD3mBenRYcNPRw/6TZrfQ5Y=
Message-ID: <aec7e5c30602082300i6257606csdc005e6a442bfec5@mail.gmail.com>
Date: Thu, 9 Feb 2006 16:00:47 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH] Dynamically allocated pageflags
Cc: linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200602022111.32930.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602022111.32930.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On 2/2/06, Nigel Cunningham <ncunningham@cyclades.com> wrote:
> Hi everyone.
>
> This is my latest revision of the dynamically allocated pageflags patch.
>
> The patch is useful for kernel space applications that sometimes need to flag
> pages for some purpose, but don't otherwise need the retain the state. A prime
> example is suspend-to-disk, which needs to flag pages as unsaveable, allocated
> by suspend-to-disk and the like while it is working, but doesn't need to
> retain any of this state between cycles.
>
> Since the last revision, I have switched to using per-zone bitmaps within each
> bitmap.
>
> I know that I could still add hotplug memory support. Is there anything else
> missing?

I like the idea of the patch, but the code looks a bit too complicated
IMO. What is wrong with using vmalloc() to allocate a virtual
contiguous range of 0-order pages (one bit per page), and then use the
functions in linux/bitmap.h...? Or maybe I'm misunderstanding.

A system that has 2 GB RAM and 4 KB pages would use 64 KB per bitmap
(one bitmap per node), which is not so bad memory wise if you plan to
use all bits.

OTOH, if your plan is to use a single bit here and there, and leave
most of the bits unused then some kind of tree is probably better.

Or does the kernel already implement some kind of data structure that
never consumes _that_ much more space than a bitmap when fully used,
and saves a lot of memory when just sparsely populated?

/ magnus
