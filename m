Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269222AbUHaVBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbUHaVBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269208AbUHaVAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:00:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:27628 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267656AbUHaVA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:00:29 -0400
Date: Tue, 31 Aug 2004 13:59:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040831205422.GD16110@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0408311357550.2295@ppc970.osdl.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <20040831203226.GB16110@elf.ucw.cz>
 <Pine.LNX.4.58.0408311336580.2295@ppc970.osdl.org> <20040831205422.GD16110@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Pavel Machek wrote:
> > 
> > However, that said, user space can trivially cache things in the 
> > filesystem, so while this may be a convenient feature, I think you should 
> > look at perhaps doing it in the _shell_ instead..
> 
> That cache should disappear as soon as I need disk
> space. I.e. userspace should never see -ENOSPC because of this kind of
> caching. This need some kernel support. Ouch and cached file should
> atomically go away as soon as main file changes, otherwise I do not
> see how multiple processes could cooperate on caching...

Well, what other projects have done is to just reserve a certain amount of 
disk for caching. See "ccache", which solves both of the above problems 
(it doesn't shrink the cache on ENOSPC, but reserving diskspace is 
accepted practice for things like this..)

		Linus
