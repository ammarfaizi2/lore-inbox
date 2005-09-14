Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVINPoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVINPoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVINPob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:44:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:9103 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030198AbVINPob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:44:31 -0400
Date: Wed, 14 Sep 2005 17:44:25 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Jacobowitz <dan@debian.org>,
       "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
Message-ID: <20050914154425.GM11338@wotan.suse.de>
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org> <4327611D.7@oberhumer.com> <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org> <20050914142204.GA19731@nevyn.them.org> <Pine.LNX.4.58.0509140753260.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509140753260.26803@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 07:55:53AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 14 Sep 2005, Daniel Jacobowitz wrote:
> > 
> > The comment for the relevant bits of the GCC configuration says it won't
> > assume this for x86, but I believe that comment is out of date. I think
> > it'll assume 16-byte alignment on entrance to non-main() functions.
> 
> Well, that's kind of the point. We _do_ have the stack aligned on
> entrance, but it looks like gcc wants it _non-aligned_. It seems to want
> it offset by the "return address push" - ie it seems to expect that it was
> aligned before the "call", but entry into the next function will thus
> _never_ be aligned.
> 
> So the kernel actually seems to have it _too_ aligned right now. 

Yes it's wrong. I would recommend to apply Markus' patch for i386
and x86-64.

-Andi
