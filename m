Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbUL2DvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbUL2DvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 22:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUL2DvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 22:51:03 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:8116
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261315AbUL2Du7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 22:50:59 -0500
Date: Tue, 28 Dec 2004 19:49:25 -0800
From: "David S. Miller" <davem@davemloft.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sunrpc] remove xdr_kmap()
Message-Id: <20041228194925.3443fbd3.davem@davemloft.net>
In-Reply-To: <20041229020938.GN771@holomorphy.com>
References: <20041228230416.GM771@holomorphy.com>
	<20041228171246.496f3eab.davem@davemloft.net>
	<20041229020938.GN771@holomorphy.com>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 18:09:38 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Tue, 28 Dec 2004 15:04:16 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
> >> In this process, I stumbled over a blatant kmap() deadlock in
> >> xdr_kmap(), which fortunately is never called.
> 
> On Tue, Dec 28, 2004 at 05:12:46PM -0800, David S. Miller wrote:
> > This got zapped by a cleanup patch by Adrian Bunk which
> > I applied yesterdat.  Linus just hasn't pulled from my
> > tree yet.
> 
> Sounds good. I only missed it because it was in the middle of a
> larger set of changes. Now I just have to find where in nfs the
> missing flush_dcache_page() calls need to be so I can boot 2.6
> on a bunch of boxen.

I remember adding the calls ages ago, wonder what happened.

I see a bunch of memclear_highpage_flush() calls, but flush_dcache_page()
calls.  I guess these are done at the sunrpc/xdr layer.

There is a flush_dcache_page() call for xdr_partial_copy_from_skb()
but calls are also needed in _copy_to_pages() and
_shift_data_right_pages().  The rest which access pages are copying
from pages, not into them, so those should be ok.

