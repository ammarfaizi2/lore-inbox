Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWGQLYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWGQLYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGQLYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:24:09 -0400
Received: from [212.70.42.180] ([212.70.42.180]:3082 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750742AbWGQLYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:24:07 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-fsdevel@vger.kernel.org
Subject: Re: "Why Reuser 4 still is not in" doc
Date: Mon, 17 Jul 2006 14:25:19 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607171425.19816.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> >> > (aside from the VFS integration debate)
> >>
> >> Anybody know what's in Reiser4 that VFS doesn't like (link please)?
> >
> > Reiser4 plug-ins have (had?) the ability to alter the semantics of
> > things, like making files into directories inside
>
> Yes, it changes the semantics. Suddenly you can "cd linux-2.6.17.tar.bz2".
> But what will stat() return? S_IFDIR? S_IFREG? S_IFANY? A .tar parser in
> kernelspace is almost never the right thing. And then a cpio parser,
> because that's what initramfs'es are made of. Not to forget .zip, because
> that's omnipresent. Oh of course we'd also need bzip2 and gzip decoder.
> BASE64 and UU anyone?

Using this as an argument against plug-ins is a bit strange.  I suppose 
somebody could go overboard and use plug-ins to implement a subKernel.  
Would this then imply that plug-ins are wrong?

> > which you could see meta-files like
> > file/uid and file/size which contained meta-data and such accessible as
> > normal files to all the unix tools (which is a very good idea IMO). You
> > could get things like chmod by just 'echo root
> >
> >> file/owner' or something, very nice.
>
> I wish you a lot of fun with users in LDAP or other exotic storage
> methods. By making Everything possible through echo, you are violating the
> unix philosophy that one tool should do one thing (though echo does just
> that). 

The unix philosophy would hold with plug-ins, as this would aid flexibility.  
Using plug-ins is a form of modularization, much like the 'one tool should 
do one thing' approach.

> And in this case, echo would be chown, chmod, tar, bzip2 all at
> once. This sounds familiar, I think I have seen this with explorer.exe
> (and its uncountable DLLs), which lets you change everything within the
> same window.

Nothing wrong with that, unless you have an allergy against explorer.

> What I think is promising are the compression/encryption plugins. ext2
> and 3 had an attribute (`lsattr`) for compression but it does not seem
> like ever implemented.

Now that's a great example for using a plug-in in the wright place.

> > This was frowned upon by kernel developers who felt that it belonged in
> > the kernel VFS (if at all), rather than in reiser4 directly.

This is really the crux of the issue.  Introducing plug-ins into the FS is 
really the wrong place, when we already have an abstracted VFS that allows 
this to be fanned out to its children.

Thanks!

--
Al

