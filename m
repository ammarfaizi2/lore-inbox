Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWIKWAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWIKWAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWIKWAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:00:47 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:45542 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965007AbWIKWAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:00:46 -0400
Date: Mon, 11 Sep 2006 17:56:26 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc6-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200609111759_MC3-1-CAE8-1802@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060911102328.861a64b3.akpm@osdl.org>

On Mon, 11 Sep 2006 10:23:28 -0700, Andrew Morton wrote:

> wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.18-rc6.tar.bz2
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/2.6.18-rc6-mm1-broken-out.tar.gz
> box:/home/akpm> mkdir aa
> box:/home/akpm> cd aa
> box:/home/akpm/aa> tar xfj ../linux-2.6.18-rc6.tar.bz2 
> box:/home/akpm/aa> cd linux-2.6.18-rc6 
> box:/home/akpm/aa/linux-2.6.18-rc6> tar xfz ../../2.6.18-rc6-mm1-broken-out.tar.gz
> box:/home/akpm/aa/linux-2.6.18-rc6> mv broken-out patches
> box:/home/akpm/aa/linux-2.6.18-rc6> quilt push -a > /dev/null
> box:/home/akpm/aa/linux-2.6.18-rc6> quilt applied | wc -l
> 1835

I found the problem:

$ set | fgrep QUILT
QUILT_DIFF_OPTS=-p
QUILT_PATCH_OPTS=--fuzz=0
                 ^^^^^^^^

Your patchset does have conflicts -- you're just ignoring them
by accepting fuzz (and patch hunks can even end up being applied
at the wrong place.)

-- 
Chuck

