Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVDZEVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVDZEVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDZEVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:21:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:34750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261314AbVDZEVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:21:07 -0400
Date: Mon, 25 Apr 2005 21:22:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
In-Reply-To: <20050426040933.GA21178@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0504252120211.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050426040933.GA21178@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Chris Wedgwood wrote:
>
> On Mon, Apr 25, 2005 at 07:08:28PM -0700, Linus Torvalds wrote:
> 
> > If you're checking in a change to 1000+ files, you're doing
> > something wrong.
> 
> arch or subsystem merge?

No, if it's a merge, you just suck in all the already-compressed objects.  

You never compress anything new - you get the objects, you update your
tree index, and you're done. No overhead anywhere - a clean merge may
_look_ like it's changing thousands of files, but it didn't change a
single _object_ anywhere, it just re-arranged the objects and created a
new view of them.

Most merges are literally just a tree-level thing. Sometimes you have to 
do a content merge, but that tends to be a file or two.

			Linus
