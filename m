Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSKOAel>; Thu, 14 Nov 2002 19:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSKOAde>; Thu, 14 Nov 2002 19:33:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:27823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265400AbSKOAda>;
	Thu, 14 Nov 2002 19:33:30 -0500
Date: Thu, 14 Nov 2002 13:38:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David.Mosberger@acm.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114213822.GO23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David.Mosberger@acm.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com> <08a601c28bbb$2f6182a0$760010ac@edumazet> <20021114141310.A25747@infradead.org> <ugel9oavk4.fsf@panda.mostang.com> <20021114203411.GG22031@holomorphy.com> <15828.5673.94643.36160@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15828.5673.94643.36160@panda.mostang.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002 12:34:11 -0800, William Lee Irwin III said:
William> (3) ->f_op->mmap() will hand -EINVAL back to userspace
William> instead of automatically placing the vma, for explicit and
William> 0 start adresses

On Thu, Nov 14, 2002 at 01:31:21PM -0800, David Mosberger-Tang wrote:
> This sounds like a receipe for creating unportable programs because
> the alignment constraints will be different from one platform to
> another.  (Adding gethugepagesize() in libc would alleviate the
> problem but it wouldn't solve it completely.)
> Overall, it does sound to me that the hugetlbfs is so specialized that
> it would be much cleaner to provide a separate interface at the
> user-level.  That would leave more flexibility should the
> implementation change over time (which it well might).
> 	--david

Okay, that's a serious problem. But it's easy to fix; I'll just call
the hugepage vma placement functions that are also used by the syscalls.


Bill
