Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVDIRON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVDIRON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDIRON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 13:14:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:23472 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261241AbVDIROK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 13:14:10 -0400
Date: Sat, 9 Apr 2005 19:14:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Luck@unix-os.sc.intel.com, Tony <tony.luck@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <Pine.LNX.4.58.0504081412190.28951@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0504090052530.15339@scrub.home>
References: <20050408041341.GA8720@taniwha.stupidest.org>
 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random>
 <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de>
 <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
 <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
 <20050408191638.GA5792@taniwha.stupidest.org> <200504082050.j38Ko4r19673@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0504081412190.28951@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Apr 2005, Linus Torvalds wrote:

> Yes.  Per-file history is expensive in git, because if the way it is 
> indexed. Things are indexed by tree and by changeset, and there are no 
> per-file indexes.
> 
> You could create per-file _caches_ (*) on top of git if you wanted to make
> it behave more like a real SCM, but yes, it's all definitely optimized for
> the things that _I_ tend to care about, which is the whole-repository
> operations.

Per file history is also expensive for another reason. The basic reason is 
that I think that a hash based storage is not the best approach for SCM. 
It's lacking locality, so the more it grows the more it has to seek to 
collect all the data.
To reduce the space usage you could replace the parent file with a sha1 
reference + delta to the new file. This is basically what monotone does 
and might cause perfomance problems if you need to restore old versions 
(e.g. if you want to annotate a file).

bye, Roman
