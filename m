Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSKNSqW>; Thu, 14 Nov 2002 13:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSKNSqW>; Thu, 14 Nov 2002 13:46:22 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:9363
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id <S261644AbSKNSqV>; Thu, 14 Nov 2002 13:46:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15827.61722.800066.756875@panda.mostang.com>
Date: Thu, 14 Nov 2002 10:53:14 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Mosberger-Tang <David.Mosberger@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove hugetlb syscalls
In-Reply-To: <1037298675.16000.47.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>
	<08a601c28bbb$2f6182a0$760010ac@edumazet>
	<20021114141310.A25747@infradead.org>
	<ugel9oavk4.fsf@panda.mostang.com>
	<1037298675.16000.47.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 14 Nov 2002 18:31:15 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> On Thu, 2002-11-14 at 17:51, David Mosberger-Tang wrote:
  >> One potential downside of this is that programmers might expect
  >> mremap(), mprotect() etc. to work on the returned memory at the
  >> granularity of base-pages.  I'm not sure though whether that was
  >> part of the reason Linus wanted separate syscalls.

  Alan> The extra syscalls dont change anything. mremap/mprotect still
  Alan> fails in the same way after you use them

But that's excactly the point.  The hugepage interface returns a
different kind of virtual memory.  There are tons of programs out
there using mmap().  If such a program gets fed a path to the
hugepagefs, it might end up with huge pages without knowing anything
about huge pages.  For the most part, that might work fine, but it
could lead to subtle failures.

	--david
