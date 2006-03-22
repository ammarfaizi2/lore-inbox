Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWCVHhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWCVHhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWCVHhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:37:40 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61856 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751076AbWCVHhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:37:39 -0500
Date: Wed, 22 Mar 2006 09:37:33 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Nathan Scott <nathans@sgi.com>
cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com
Subject: Re: [xfs-masters] Re: [PATCH] xfs: kill kmem_zone init
In-Reply-To: <20060322085520.A664708@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0603220932230.27326@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603201501540.18684@sbz-30.cs.Helsinki.FI>
 <20060321082037.A653275@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.58.0603210859450.14023@sbz-30.cs.Helsinki.FI>
 <20060322085520.A664708@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006, Nathan Scott wrote:
> Regarding __GFP_NOFAIL, there are some situations where that could
> be used now, and others where it should not be - it'd take a very
> careful code audit and evidence of a level of low-memory-condition
> testing done, etc, before such a change would be merged.  Note that
> the -mm tree currently has a rework of the way incore extents are
> managed within XFS, which significantly changes (in a good way) the
> nature of the allocation requests we make (and hence I'm _really_,
> _really_ not interested in cosmetic patches in this area just now).

Yeah, just drop it then. After digging through your kmem_zone stuffs, I 
noticed you're using PF_FSTRANS in kmem_flags_convert() to detect GFP_NOFS 
cases which makes conversion to slab proper very difficult anyway. Would 
you accept patches to convert code under PF_FSTRANS to use KM_NOFS so we 
can kill the check in kmem_flags_convert()?

				Pekka
