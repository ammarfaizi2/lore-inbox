Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUJZEIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUJZEIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUJZEIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:08:19 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:60555 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262085AbUJZEDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:03:39 -0400
Date: Tue, 26 Oct 2004 06:04:29 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041026040429.GW14325@dualathlon.random>
References: <20041025170128.GF14325@dualathlon.random> <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com> <20041026015825.GU14325@dualathlon.random> <417DC8F2.7000902@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417DC8F2.7000902@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 01:48:02PM +1000, Nick Piggin wrote:
> I see classzone_idx snuck in, can we leave that as alloc_type please?

when I wrote that code in 2.4 it was called class_idx. Just to show it
was not an opaque type, in this 2.6 I called it classzone_idx but it's
the same as class_idx. If you feel classzone_idx is too long I'm sure
fine to rename to class_idx like plain 2.4.

The reason I renamed it is that alloc_type tells nothing to who's
reading the code. That value in the opaque "alloc_type" variable, is
really the classzone_idx that identify the classzone we have to allocate
memory from. Classzone 2 means "all ram is good", classzone 2 means
"zone-normal + zone-dma is good", classzone 0 means "zone-dma is good".

alloc_type means very very little to me, calling it with a meaningful
name made the code more readable for me. gfp_mask describes other alloc
types as well that are not less singificant than the classzone_idx, so I
don't see why we should go back to the opaque variable name when we can
have a more descriptive one.

I'm not going to nitpick further on this detail though, all I care about
is the asm generated and not breaking ABIs with userspace (i.e. at least
one forced rename to the sysctl).

thanks for the review!
