Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVJKVMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVJKVMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVJKVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:12:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41654 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932075AbVJKVMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:12:20 -0400
Date: Tue, 11 Oct 2005 22:12:15 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
       "Jonathan M. McCune" <jonmccune@cmu.edu>, linux-kernel@vger.kernel.org,
       Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>
Subject: Re: using segmentation in the kernel
Message-ID: <20051011211215.GV7992@ftp.linux.org.uk>
References: <434C1D60.2090901@cmu.edu> <434C2269.5090209@didntduck.org> <434C1F8E.6080405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434C1F8E.6080405@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 10:24:46PM +0200, Alon Bar-Lev wrote:
> Brian Gerst wrote:
> >Jonathan M. McCune wrote:
> >
> >>Hello,
> >>
> >Why send the kernel back to the 2.0 days?  There is no valid reason for 
> >doing this with they way x86 segmentation works, which is why it was 
> >done away with in 2.1.
> >
> 
> But with segmentation you can set code to be read-only, 
> disallow execution from stack, separate modules so that they 
> will not affect kernel and more...

You do realize that it's a BS, don't you?

* attacker that would rewrite kernel code can switch a pointer to method in
any of the method tables (or pointer to the entire method table, while we are
at it).
* overwriting return address is trivial if you got stack smashing and there
is a plenty of interesting functions in the kernel ready to elevate priveleges
* modules rely on practically complete access to kernel data structures, so
no amount of playing with rings will change anything for them.
