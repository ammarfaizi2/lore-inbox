Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbWJFGqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWJFGqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 02:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWJFGqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 02:46:00 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:12160 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932646AbWJFGp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 02:45:58 -0400
Date: Fri, 6 Oct 2006 12:15:41 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] fdtable: Make fdarray and fdsets equal in size.
Message-ID: <20061006064541.GA6751@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200610052151.04490.vlobanov@speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610052151.04490.vlobanov@speakeasy.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 09:51:04PM -0700, Vadim Lobanov wrote:
> Currently, each fdtable supports three dynamically-sized arrays of data: the
> fdarray and two fdsets. The code allows the number of fds supported by the
> fdarray (fdtable->max_fds) to differ from the number of fds supported by each
> of the fdsets (fdtable->max_fdset). In practice, it is wasteful for these two
> sizes to differ: whenever we hit a limit on the smaller-capacity structure, we
> will reallocate the entire fdtable and all the dynamic arrays within it, so
> any delta in the memory used by the larger-capacity structure will never be
> touched at all. Rather than hogging this excess, we shouldn't even allocate it
> in the first place, and keep the capacities of the fdarray and the fdsets
> equal. This patch removes fdtable->max_fdset. As an added bonus, most of the
> supporting code becomes simpler.
> 
> Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

I agree with this patch in principle that it saves space and makes
the lockfree fdtable code simpler. However, it would be nice if
Viro or Christoph has a look at this and comment on why
we always had two different sizes.

Thanks
Dipankar
