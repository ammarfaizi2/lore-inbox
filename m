Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbTHWVxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTHWVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:52:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53179 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263341AbTHWVwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 17:52:18 -0400
Date: Sat, 23 Aug 2003 14:44:36 -0700
From: "David S. Miller" <davem@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: James.Bottomley@SteelEye.com, willy@debian.org,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
 tst-mmap-eofsync in glibc on parisc)
Message-Id: <20030823144436.63cf118f.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0308230820020.3590-100000@localhost.localdomain>
References: <1061600974.2090.809.camel@mulgrave>
	<Pine.LNX.4.44.0308230820020.3590-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 08:22:19 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> On 22 Aug 2003, James Bottomley wrote:
> > 
> > I suppose if we had a way of telling if any of the i_mmap list members
> > were really MAP_SHARED semantics mappings, then we could alter our
> > flush_dcache_page() implementation to work.
> 
> Good idea.  It's VM_MAYSHARE you need to check for.

Nope, please see my other email for why all of these ideas
simply will not work.  If the first fault-in of a MAP_PRIVATE
page is a read, it's just like a MAP_SHARED read-only page until
the first write occurs.
