Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVJKDl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVJKDl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVJKDl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:41:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51146 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751370AbVJKDl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:41:28 -0400
Date: Tue, 11 Oct 2005 04:41:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Tom 'spot' Callaway" <tcallawa@redhat.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Linux v2.6.14-rc4
Message-ID: <20051011034127.GS7992@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 06:31:12PM -0700, Linus Torvalds wrote:
> Tom 'spot' Callaway:
>       [SPARC32]: Enable generic IOMAP.

... breaks non-PCI builds (aka the absolute majority of sparc32 boxen).
On sparc32 insl() et.al. are defined only if CONFIG_PCI is set.

Moreover, I really doubt that generic_iomap is the right thing to do
there - all these guys end up as memory dereferences anyway, so ioread...()
et.al. have no reason to care about the origin of iomem pointer they get.

Note that generic iomap is needed only when we have separate IO port space
that needs different access.  And for those we imitate iomem.  AFAICS,
on sparc32 *everything* is iomem anyway, so WTF do we need lib/iomem.c?
