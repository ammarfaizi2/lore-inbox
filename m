Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTEOVzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTEOVzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:55:38 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39233 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264266AbTEOVzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:55:37 -0400
Date: Thu, 15 May 2003 15:03:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 2 potential out-of-bound user-pointer errors in
 fs/readdir.c
Message-Id: <20030515150344.1b2686f2.akpm@digeo.com>
In-Reply-To: <Pine.GSO.4.44.0305151329550.29285-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0305112337160.3242-100000@elaine24.Stanford.EDU>
	<Pine.GSO.4.44.0305151329550.29285-100000@elaine24.Stanford.EDU>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 22:08:22.0705 (UTC) FILETIME=[80096210:01C31B2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> wrote:
>
> 
> Hi,
> 
> Enclosed are two warnings found in fs/readdir.c, where user provided
> pointers are accessed out of 'verified' bounds.
> 
> The warnings are found by: first, whenenver we see calls to verify_area,
> access_ok and all the no-underscore versions of *_user functions, we
> remember the verified bounds. when a user-pointer is accessed thru
> __*_user functions, we check if the verified bound is big enough.
> 
> Please confirm or clarify. Thanks!

The code as-is appears to be OK.  Note how sys_getdents64() will run
access_ok() against the entire user buffer up-front.  Then the start/len of
that verified area is copied into the getdents_callback64 and that is
propagated down to filldir64().

And filldir64() looks like it correctly remains within the bounds of the
start/len.

I guess that copy_to_user() should be __copy_to_user().


