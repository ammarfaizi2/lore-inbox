Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWALR4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWALR4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWALR4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:56:50 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:37287 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932514AbWALR4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:56:49 -0500
Date: Thu, 12 Jan 2006 12:53:08 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] fix i386 mutex fastpath on FRAME_POINTER && 
  !DEBUG_MUTEXES
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>
Message-ID: <200601121256_MC3-1-B5C3-FDE0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.58.0601110511590.24014@devserv.devel.redhat.com>

On Wed, 11 Jan 2006, Ingo Molnar wrote:

> On Wed, 11 Jan 2006, Chuck Ebbert wrote:
>
> > 
> >                 LOCK    "   decl (%%eax)        \n"                     \
> >                         "   jns 1f              \n"                     \
> >                         "   call "#fail_fn"     \n"                     \
> >                         "1:                     \n"                     \
> >                                                                         \
> >                 :"=a" (dummy)                                           \
> >                 : "a" (count)                                           \
> > 
> > 
> > Will the extra taken forward conditional jump in the fastpath cause much
> > of a slowdown?
> 
> yeah - the fastpath is much more common than the slowpath.

But that's how the spinlock code does it.  Should that be changed to put the
spinloops in .text.lock and make the fastpaths a fall-through?

-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
