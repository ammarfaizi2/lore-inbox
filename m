Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUEGUCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUEGUCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUEGUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:02:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:65376 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261913AbUEGT4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 15:56:11 -0400
Date: Fri, 7 May 2004 18:43:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Timothy Miller <miller@techsource.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>, <vonbrand@inf.utfsm.cl>,
       <nickpiggin@yahoo.com.au>, <jgarzik@pobox.com>,
       <brettspamacct@fastclick.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <409BC7A7.4060203@techsource.com>
Message-ID: <Pine.LNX.4.44.0405071836530.21102-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Timothy Miller wrote:
> > 
> >>>Perhaps what we really want is "swap_back_in" script? That way you
> >>>could do "updatedb; swap_back_in" in cron and be happy.
> >>
> >>swapoff -a; swapon -a
> 
> Wouldn't this also be a problem if you are using more memory than you 
> have physical RAM?

On 2.4 it certainly would be a problem (hang with others OOM-killed).

On 2.6 it shouldn't be a problem: the swapoff may fail upfront if
there's way too little memory, or it may get itself OOM-killed if
it runs out on the way, but it ought not to upset other tasks.

But of course, Pavel is right that it does nothing for file backed.

Hugh

