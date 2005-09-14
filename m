Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbVINO4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbVINO4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVINO4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:56:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965229AbVINO4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:56:07 -0400
Date: Wed, 14 Sep 2005 07:55:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
In-Reply-To: <20050914142204.GA19731@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0509140753260.26803@g5.osdl.org>
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org>
 <4327611D.7@oberhumer.com> <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
 <20050914142204.GA19731@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Sep 2005, Daniel Jacobowitz wrote:
> 
> The comment for the relevant bits of the GCC configuration says it won't
> assume this for x86, but I believe that comment is out of date. I think
> it'll assume 16-byte alignment on entrance to non-main() functions.

Well, that's kind of the point. We _do_ have the stack aligned on
entrance, but it looks like gcc wants it _non-aligned_. It seems to want
it offset by the "return address push" - ie it seems to expect that it was
aligned before the "call", but entry into the next function will thus
_never_ be aligned.

So the kernel actually seems to have it _too_ aligned right now. 

			Linus
