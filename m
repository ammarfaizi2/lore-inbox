Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268920AbUIMUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268920AbUIMUWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUIMUWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:22:11 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51998 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268928AbUIMUTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:19:12 -0400
Date: Mon, 13 Sep 2004 21:18:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Tonnerre <tonnerre@thundrix.ch>
cc: Roman Zippel <zippel@linux-m68k.org>, Alex Zarochentsev <zam@namesys.com>,
       Paul Jackson <pj@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined atomic_s
    ub_and_test
In-Reply-To: <20040913200359.GE19399@thundrix.ch>
Message-ID: <Pine.LNX.4.44.0409132113040.3868-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Tonnerre wrote:
> On Mon, Sep 13, 2004 at 06:03:28PM +0200, Roman Zippel wrote:
> > +#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
> > +#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
> 
> This is no longer atomic, is it? I mean, there's no guarantee that the
> atomic_add_return   and   the    comparison   are   executed   without
> interruption, is there?

It's true that the atomic_add_return and the comparison are not executed
atomically, but they don't need to be: a value is equal to 0, or not,
however long ago that value was computed, no matter what happened since.

The important thing is that the value is the atomic result of the atomic
operation: which may not be the case when you use atomic_add followed by
atomic_read, but is what's guaranteed by atomic_add_return.

Hugh

