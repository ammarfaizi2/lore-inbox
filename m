Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267652AbUHaUhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUHaUhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269173AbUHaUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:36:04 -0400
Received: from gprs214-69.eurotel.cz ([160.218.214.69]:36738 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268800AbUHaUdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:33:05 -0400
Date: Tue, 31 Aug 2004 22:32:26 +0200
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
Message-ID: <20040831203226.GB16110@elf.ucw.cz>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You do need extra tools anyway, placing them in the kernel is cheating (and
> > absolutely pointless, IMHO).
> 
> I agree.
> 
> There's no point to having the kernel export information that is already 
> inherent in the main stream.
> 
> I've seen all these examples of exposing MP3 ID information as a "side 
> stream", and that's TOTALLY POINTLESS! The information is already there, 
> it's in a standard format, and exporting it as a stream buys you 
> absolutely nothing.

It buys me caching. I do quite often

bzcat patch.2.6.8.bz2 | less (read the patch)
(sometimes repeat that few times because I hit ^c when I should not
have etc).
cd ...clean; bzcat patch.2.6.8.bz2 | patch -Esp1
cd ...linux; bzcat patch.2.6.8.bz2 | patch -Esp1

Now... that's total waste of cpu. bzip2 decompression takes quite some
time. 

I could do

bzcat patch.2.6.8.bz2 > /tmp/delete.me.when.you.are.done

...but I'd probably forget to delete that one and anyway, it requires
me to think about it. Nicest way would be

cat patch.2.6.8.bz2/ubz | less
cd ...clean; cat patch.2.6.8.bz2/ubz | patch -Esp1
cd ...linux; cat patch.2.6.8.bz2/ubz | patch -Esp1

with kernel intelligently caching uncompressed data. I believe this
can not be done completely in userspace.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
