Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRDJKmY>; Tue, 10 Apr 2001 06:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132962AbRDJKmO>; Tue, 10 Apr 2001 06:42:14 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:39036 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131459AbRDJKmF>; Tue, 10 Apr 2001 06:42:05 -0400
Date: Tue, 10 Apr 2001 06:41:28 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] amusing copy_from_user bug
Message-ID: <20010410064128.C1169@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <200104101011.DAA29579@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104101011.DAA29579@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Tue, Apr 10, 2001 at 03:11:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 03:11:05AM -0700, Dawson Engler wrote:
> As a side question: is it still true that verify_area's must be done before
> any use of __put_user/__get_user/__copy_from_user/etc?

I believe so, at least in generic code.
In architecture specific code (non-i386) it is usually sufficient just to do
one put_user/get_user/copy_from_user and then do the rest of
__put_user/__get_user etc. from nearby area (<4K is safe e.g. on sparc) and
some architectures don't care at all, because verify_area is a noop
(sparc64).

	Jakub
