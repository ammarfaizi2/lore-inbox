Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTEPAQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTEPAQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:16:25 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:4543 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264094AbTEPAQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:16:24 -0400
Date: Thu, 15 May 2003 17:29:08 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 2 potential out-of-bound user-pointer errors in
 fs/readdir.c
In-Reply-To: <20030515150344.1b2686f2.akpm@digeo.com>
Message-ID: <Pine.GSO.4.44.0305151727560.18402-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the clarifications! so these are not real security bugs, but
redundant checks.

-Junfeng

On Thu, 15 May 2003, Andrew Morton wrote:

> Junfeng Yang <yjf@stanford.edu> wrote:
> >
> >
> > Hi,
> >
> > Enclosed are two warnings found in fs/readdir.c, where user provided
> > pointers are accessed out of 'verified' bounds.
> >
> > The warnings are found by: first, whenenver we see calls to verify_area,
> > access_ok and all the no-underscore versions of *_user functions, we
> > remember the verified bounds. when a user-pointer is accessed thru
> > __*_user functions, we check if the verified bound is big enough.
> >
> > Please confirm or clarify. Thanks!
>
> The code as-is appears to be OK.  Note how sys_getdents64() will run
> access_ok() against the entire user buffer up-front.  Then the start/len of
> that verified area is copied into the getdents_callback64 and that is
> propagated down to filldir64().
>
> And filldir64() looks like it correctly remains within the bounds of the
> start/len.
>
> I guess that copy_to_user() should be __copy_to_user().
>
>

