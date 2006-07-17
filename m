Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWGQJnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWGQJnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 05:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWGQJnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 05:43:09 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:64691 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750706AbWGQJnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 05:43:08 -0400
Date: Mon, 17 Jul 2006 11:42:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lexington Luthor <Lexington.Luthor@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: "Why Reuser 4 still is not in" doc
In-Reply-To: <e9eg1v$5sf$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0607171132430.11447@yvahk01.tjqt.qr>
References: <20060716161631.GA29437@httrack.com>  <20060716162831.GB22562@zeus.uziel.local>
  <20060716165648.GB6643@thunk.org> <e9dsrg$jr1$1@sea.gmane.org> 
 <20060716174804.GA23114@thunk.org>  <20060716220115.a1891231.diegocg@gmail.com>
  <e9ea1v$nc4$1@sea.gmane.org> <bda6d13a0607161428j187b737ft6f3925d9a3b2cc72@mail.gmail.com>
 <e9eg1v$5sf$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > (aside from the VFS integration debate)
>> Anybody know what's in Reiser4 that VFS doesn't like (link please)?
>
> Reiser4 plug-ins have (had?) the ability to alter the semantics of things, like
> making files into directories inside

Yes, it changes the semantics. Suddenly you can "cd linux-2.6.17.tar.bz2". 
But what will stat() return? S_IFDIR? S_IFREG? S_IFANY? A .tar parser in 
kernelspace is almost never the right thing. And then a cpio parser, 
because that's what initramfs'es are made of. Not to forget .zip, because 
that's omnipresent. Oh of course we'd also need bzip2 and gzip decoder. 
BASE64 and UU anyone?

> which you could see meta-files like
> file/uid and file/size which contained meta-data and such accessible as normal
> files to all the unix tools (which is a very good idea IMO). You could get
> things like chmod by just 'echo root 
>> file/owner' or something, very nice.

I wish you a lot of fun with users in LDAP or other exotic storage methods.
By making Everything possible through echo, you are violating the unix 
philosophy that one tool should do one thing (though echo does just that). 
And in this case, echo would be chown, chmod, tar, bzip2 all at once. This 
sounds familiar, I think I have seen this with explorer.exe (and its 
uncountable DLLs), which lets you change everything within the same 
window.

What I think is promising are the compression/encryption plugins. ext2 
and 3 had an attribute (`lsattr`) for compression but it does not seem like 
ever implemented.

> This was frowned upon by kernel developers who felt that it belonged in the
> kernel VFS (if at all), rather than in reiser4 directly.


Jan Engelhardt
-- 
