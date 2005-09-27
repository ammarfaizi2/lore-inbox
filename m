Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVI0NGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVI0NGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVI0NGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:06:42 -0400
Received: from nevyn.them.org ([66.93.172.17]:41407 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S964913AbVI0NGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:06:41 -0400
Date: Tue, 27 Sep 2005 09:06:39 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Message-ID: <20050927130639.GA606@nevyn.them.org>
Mail-Followup-To: "Bhavesh P. Davda" <bhavesh@avaya.com>,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.33.0509261129280.20665-200000@drces.dr.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0509261129280.20665-200000@drces.dr.avaya.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 11:39:40AM -0600, Bhavesh P. Davda wrote:
> 
> Sometimes when a task is being ptraced (e.g. by a debugger), one would
> like to handle a certain signal (e.g. SIGSEGV) within the task without
> having to notify the ptracing task.
> 
> An example of this is if one would like to detect the rate at which pages
> are being modified, and therefore mprotect() the pages. The SIGSEGV
> handler just keeps track of how many writes are happening on each of the
> mprotect()ed pages, but you don't want to bother the debugger with these
> SIGSEGVs.
> 
> I'm proposing the addition of a new SA_NOPRNOTIF flag to struct sigaction
> { sa_flags }, which makes the kernel skip notifying the ptracing parent if
> the flag is set for a sighandler for a particular signal.
> 
> This trivial patch achieves just that.
> 
> Comments?

No way!  It needs to work the other way: allow the debugger to
short-circuit a signal for performance reasons if it wants to.  Ptrace
is supposed to report all signals and debuggers expect it to do so.
It'd be pretty confusing if, say, you were trying to debug the SIGSEGV
handler in an application which did this.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
