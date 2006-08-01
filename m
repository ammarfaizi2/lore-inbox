Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWHAQ4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWHAQ4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWHAQ4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:56:03 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:9916 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1750827AbWHAQ4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:56:01 -0400
Message-ID: <44CF879D.1000803@slaphack.com>
Date: Tue, 01 Aug 2006 11:55:57 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
CC: Andrew Morton <akpm@osdl.org>, vda.linux@googlemail.com,
       linux-kernel@vger.kernel.org, Reiserfs-List@namesys.com
Subject: Re: reiser4: maybe just fix bugs?
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>	 <20060801013104.f7557fb1.akpm@osdl.org> <44CEBA0A.3060206@namesys.com>	 <1154431477.10043.55.camel@tribesman.namesys.com>	 <20060801073316.ee77036e.akpm@osdl.org> <1154444822.10043.106.camel@tribesman.namesys.com>
In-Reply-To: <1154444822.10043.106.camel@tribesman.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir V. Saveliev wrote:

> Do you think that if reiser4 supported xattrs - it would increase its
> chances on inclusion?

Probably the opposite.

If I understand it right, the original Reiser4 model of file metadata is 
the file-as-directory stuff that caused such a furor the last big push 
for inclusion (search for "Silent semantic changes in Reiser4"):

foo.mp3/.../rwx    # permissions
foo.mp3/.../artist # part of the id3 tag

So I suspect xattrs would just be a different interface to this stuff, 
maybe just a subset of it (to prevent namespace collisions):

foo.mp3/.../xattr/ # contains files representing attributes

Of course, you'd be able to use the standard interface for 
getting/setting these.  The point is, I don't think Hans/Namesys wants 
to do this unless they're going to do it right, especially because they 
already have the file-as-dir stuff somewhat done.  Note that these are 
neither mutually exclusive nor mutually dependent -- you don't have to 
enable file-as-dir to make xattrs work.

I know it's not done yet, though.  I can understand Hans dragging his 
feet here, because xattrs and traditional acls are examples of things 
Reiser4 is supposed to eventually replace.

Anyway, if xattrs were done now, the only good that would come of it is 
building a userbase outside the vanilla kernel.  I can't see it as doing 
anything but hurting inclusion by introducing more confusion about 
"plugins".

I could be entirely wrong, though.  I speak for neither 
Hans/Namesys/reiserfs nor LKML.  Talk amongst yourselves...
