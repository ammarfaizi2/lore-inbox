Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbUJ1Awi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbUJ1Awi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUJ1Awe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:52:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:16591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262643AbUJ1Ar4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:47:56 -0400
Date: Wed, 27 Oct 2004 17:47:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove some divide instructions
In-Reply-To: <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410271731010.28839@ppc970.osdl.org>
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
 <41801DE1.6000007@vmware.com> <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Oct 2004, Linus Torvalds wrote:
> 
> I could add a sparse check for "no side effects", if anybody cares (so 
> that you could do
> 
> 	__builtin_warning(
> 		!__builtin_nosideeffects(base),
> 		"expression has side effects");
> 
> in macros like these.. Sparse already has the logic internally..

Done. Except I called it __builtin_safe_p(). 

The kernel sources already know about "__builtin_warning()" (and 
pre-process it away on gcc), so if you have a new sparse setup (as of two 
minutes ago ;), you can use this thing to check that arguments to macros 
do not have side effects.

Useful? You be the judge. But it was just a couple of lines in sparse, and
doing so also made it obvious how to clean up __builtin_constant_p() a lot
at the same time by just re-organizing things a bit.

My inliner and statement simplificator isn't perfect, so inline functions
sadly are not considered constant (or safe) even if they _do_ end up
returning a constant value (or be safe internally).

		Linus
