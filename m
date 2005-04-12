Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVDLNOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVDLNOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVDLNND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:13:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10163 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262391AbVDLNHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 09:07:48 -0400
Subject: Re: [ANNOUNCE] git-pasky-0.3
From: David Woodhouse <dwmw2@infradead.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
In-Reply-To: <20050411135758.GA3524@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	 <20050409200709.GC3451@pasky.ji.cz>
	 <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
	 <20050411015852.GI5902@pasky.ji.cz>  <20050411135758.GA3524@pasky.ji.cz>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 14:07:36 +0100
Message-Id: <1113311256.20848.47.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 15:57 +0200, Petr Baudis wrote:
>   Hello,
> 
>   here goes git-pasky-0.3, my set of patches and scripts upon
> Linus' git, aimed at human usability and to an extent a SCM-like
> usage.

Untar, make, add to path, pull, 'git diff' fails on PPC:

peach /home/dwmw2/git-pasky-base $ git diff
error: bad signature
error: verify header failed
read_cache: Invalid argument

A little extra debugging shows the problem:

error: bad signature 0x43524944 should be 0x44495243

The cache.h header file suggests that the cache is host-endian on
purpose, because it's local-only. So why am I seeing a cache from
another host? Is that comment no longer true?

Either way, the original decision is probably bogus -- with trees as
large as the kernel tree it makes a lot of sense to keep them somewhere
NFS-accessible and use them from different hosts, and byteswapping
really isn't going to slow it down that much. We should just pick an
endianness and stick to it.

I'd suggest making it big-endian to make sure the LE weenies don't
forget to byteswap properly.

-- 
dwmw2

