Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUHaU5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUHaU5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269029AbUHaU4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:56:44 -0400
Received: from gprs214-69.eurotel.cz ([160.218.214.69]:39554 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267650AbUHaUy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:54:57 -0400
Date: Tue, 31 Aug 2004 22:54:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040831205422.GD16110@elf.ucw.cz>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <20040831203226.GB16110@elf.ucw.cz> <Pine.LNX.4.58.0408311336580.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408311336580.2295@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It buys me caching.
> 
> I'll actually buy into that. If only because I consider caching to be one 
> of the more important things that the kernel does (caches are a _classic_ 
> case of "shared data that needs synchronization").
> 
> However, that said, user space can trivially cache things in the 
> filesystem, so while this may be a convenient feature, I think you should 
> look at perhaps doing it in the _shell_ instead..

That cache should disappear as soon as I need disk
space. I.e. userspace should never see -ENOSPC because of this kind of
caching. This need some kernel support. Ouch and cached file should
atomically go away as soon as main file changes, otherwise I do not
see how multiple processes could cooperate on caching...

chattr +kill-this-file-when-low-on-disk-space patch.bz2...ubz 

would solve first problem. Not sure how to do the second one.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
