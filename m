Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVDKS3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVDKS3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVDKS3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:29:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:59609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261875AbVDKS2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:28:38 -0400
Date: Mon, 11 Apr 2005 11:30:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@engr.sgi.com>, pasky@ucw.cz,
       rddunlap@osdl.org, ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
In-Reply-To: <20050411181319.GA11302@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0504111127320.1267@ppc970.osdl.org>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu>
 <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu>
 <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org> <20050411153905.GA7284@elte.hu>
 <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org> <20050411181319.GA11302@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Chris Wedgwood wrote:
>
> On Mon, Apr 11, 2005 at 09:01:51AM -0700, Linus Torvalds wrote:
> 
> > I disagree. Yes, the thing is designed to be replicated, so most of
> > the time the easiest thing to do is to just rsync with another copy.
> 
> It's not clear how any of this is going to give me something like
> 
>      bk changes -R
> 
> or
>      bk changes -L
> 
> functionality. 

You'd dowload all the sha1 objects (they don't actually do anything to
_your_ state - they only show the possible other states), and then it's a 
"simple thing" to generate a full tree of your local HEAD commit and 
compare it to a full tree of the remove HEAD commit.

If you then want to merge, you already have all the data. If you don't,
you can then prune your object tree from the stuff you don't use (fsck
already effectively does all the connectivity work, it just never removes
unreferenced files).

		Linus
