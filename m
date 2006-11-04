Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWKDHDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWKDHDd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 02:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWKDHDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 02:03:33 -0500
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:31974 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932429AbWKDHDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 02:03:32 -0500
Date: Sat, 4 Nov 2006 01:56:51 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Benjamin LaHaise <bcrl@kvack.org>
Message-ID: <200611040200_MC3-1-D04D-6EA3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0611031645141.25218@g5.osdl.org>

On Fri, 3 Nov 2006 16:46:25 -0800, Linus Torvalds wrote:

> On Fri, 3 Nov 2006, Chuck Ebbert wrote:
> >
> > There is no real need to save eflags in switch_to().  Instead,
> > we can keep a constant value in the thread_struct and always
> > restore that.
> 
> I don't really see the point. The "pushfl" isn't the expensive part, and 
> it gives sane and expected semantics.
> 
> The "popfl" is the expensive part, and that's the thing that can't really 
> even be removed.

Well that wasn't the impression I got:

  Date: Mon, 18 Sep 2006 12:12:51 -0400
  From: Benjamin LaHaise <bcrl@kvack.org>
  Subject: Re: Sysenter crash with Nested Task Bit set

  ...

  It's the pushfl that will be slow on any OoO CPU, as it has dependancies on 
  any previous instructions that modified the flags, which ends up bringing 
  all of the memory ordering dependancies into play.  Doing a popfl to set the 
  flags to some known value is much less expensive.


And benchmarks seem to support that, even on K8:

 lmbench context switch, 50 runs

        before  after
    avg  1.09   1.05
 stddev   .25    .18

But P4 is the real problem case and I can't test that.

-- 
Chuck
"Even supernovas have their duller moments."

