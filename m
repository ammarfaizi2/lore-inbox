Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUIOSkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUIOSkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUIOSkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:40:35 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:56575 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267278AbUIOSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:40:12 -0400
Date: Wed, 15 Sep 2004 11:40:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915184007.GB11313@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:07:29AM -0700, Linus Torvalds wrote:

> C doesn't. gcc does. It's a documented extension, and it acts like
> if it was done on a byte.

[...]

> It's a singularly good feature.

I dunno about that.  Maybe it is, but it has some gotchas.

Recently when doing a sparsification of code I noticed there are
places which essentially do things like:

    void *foo;

    [...]

    foo += bar * n;

Part of the fix (cleanup) was to change the 'void *foo' to
'gratuitous_typedef_t __user *foo' --- which silently breaks the math
if you don't explicitly check for this.


  --cw
