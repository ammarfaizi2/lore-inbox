Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUKSFa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUKSFa3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 00:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUKSFa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 00:30:29 -0500
Received: from waste.org ([209.173.204.2]:20364 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261256AbUKSFaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 00:30:25 -0500
Date: Thu, 18 Nov 2004 21:29:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 17/20] FRV: Better mmap support in uClinux
Message-ID: <20041119052936.GE8040@waste.org>
References: <20040401020550.GG3150@beast> <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 02:34:20PM +0000, dhowells@redhat.com wrote:

>  (3) Files (and blockdevs) cannot be mapped shared since it is not
>  really possible to honour this by writing any changes back to the
>  backing device.

[way behind on email]

I think this could be done at msync, munmap and exit time? You end up
flushing the entire mapping, but it's still correct (and POSIX
compliant).

And, if you wanted to be really clever, you could store a hash of each
page to detect changes and avoid the extra I/O.

-- 
Mathematics is the supreme nostalgia of our time.
