Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVDHV0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDHV0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVDHV0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:26:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:11727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbVDHVZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:25:44 -0400
Date: Fri, 8 Apr 2005 14:27:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Luck@unix-os.sc.intel.com, Tony <tony.luck@intel.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <200504082050.j38Ko4r19673@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0504081412190.28951@ppc970.osdl.org>
References: <20050408041341.GA8720@taniwha.stupidest.org>
 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random>
 <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de>
 <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
 <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
 <20050408191638.GA5792@taniwha.stupidest.org> <200504082050.j38Ko4r19673@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005 Luck@unix-os.sc.intel.com wrote:
>
> It looks like an operation like "show me the history of mm/memory.c" will
> be pretty expensive using git.

Yes.  Per-file history is expensive in git, because if the way it is 
indexed. Things are indexed by tree and by changeset, and there are no 
per-file indexes.

You could create per-file _caches_ (*) on top of git if you wanted to make
it behave more like a real SCM, but yes, it's all definitely optimized for
the things that _I_ tend to care about, which is the whole-repository
operations.

		Linus

(*) Doing caching on that level is probably find, especially since most
people really tend to want it for just the relatively few files that they
work on anyway. Limiting the caches to a subset of the tree should be
quite effective.
