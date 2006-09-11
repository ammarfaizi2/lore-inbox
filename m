Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWIKWgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWIKWgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIKWgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:36:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932169AbWIKWgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:36:09 -0400
Date: Mon, 11 Sep 2006 15:35:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060911153537.f3bfbbea.akpm@osdl.org>
In-Reply-To: <200609111759_MC3-1-CAE8-1802@compuserve.com>
References: <200609111759_MC3-1-CAE8-1802@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 17:56:26 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <20060911102328.861a64b3.akpm@osdl.org>
> 
> On Mon, 11 Sep 2006 10:23:28 -0700, Andrew Morton wrote:
> 
> > wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.18-rc6.tar.bz2
> > wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/2.6.18-rc6-mm1-broken-out.tar.gz
> > box:/home/akpm> mkdir aa
> > box:/home/akpm> cd aa
> > box:/home/akpm/aa> tar xfj ../linux-2.6.18-rc6.tar.bz2 
> > box:/home/akpm/aa> cd linux-2.6.18-rc6 
> > box:/home/akpm/aa/linux-2.6.18-rc6> tar xfz ../../2.6.18-rc6-mm1-broken-out.tar.gz
> > box:/home/akpm/aa/linux-2.6.18-rc6> mv broken-out patches
> > box:/home/akpm/aa/linux-2.6.18-rc6> quilt push -a > /dev/null
> > box:/home/akpm/aa/linux-2.6.18-rc6> quilt applied | wc -l
> > 1835
> 
> I found the problem:
> 
> $ set | fgrep QUILT
> QUILT_DIFF_OPTS=-p
> QUILT_PATCH_OPTS=--fuzz=0
>                  ^^^^^^^^
> 
> Your patchset does have conflicts -- you're just ignoring them
> by accepting fuzz (and patch hunks can even end up being applied
> at the wrong place.)
> 

Sure.  The -mm queue always has large amount of fuzz.  Lots and lots.  I'll
occasionally go and rediff the fuzzy patches to clean things up, but that
involves pointlessly incrementing the local version number on 200-300
patches, which I prefer to avoid.
