Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbTIERTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbTIERTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:19:50 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:41960 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265691AbTIERTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:19:49 -0400
Date: Fri, 5 Sep 2003 13:19:29 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andreas Jaeger <aj@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       rth@redhat.com, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905131929.Q11756@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org> <ho65k76z9v.fsf@byrd.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ho65k76z9v.fsf@byrd.suse.de>; from aj@suse.de on Fri, Sep 05, 2003 at 05:17:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 05:17:00PM +0200, Andreas Jaeger wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Fri, 5 Sep 2003, Andi Kleen wrote:
> >> 
> >> Unfortunately the kernel doesn't compile with unit-at-a-time currently,
> >> it cannot tolerate the reordering of functions in relation to inline
> >> assembly.
> >
> > What is the problem exactly? Is it the exception table getting unordered?  
> > We _could_ just sort it at boot-time (or, even better, at build time after
> > the final link) instead...
> 
> The problem is that unit-at-a-time sees all functions used and finds
> some static functions/variables that are not called anywhere and
> therefore drops them, making a smaller binary.  Since GCC does not
> look into inline assembler, anything referenced from inline assembler
> only, will be treated as not used and therefore removed.
> 
> You have to options:
> - use attribute ((used)) (implemented since GCC 3.2) to tell GCC that
>   a function/variable should never be removed

To be precise, implemented since GCC 3.2 for functions and since GCC 3.3
for variables.

	Jakub
