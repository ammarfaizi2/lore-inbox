Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVDYCmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVDYCmn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 22:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVDYCmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 22:42:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:14999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262466AbVDYCmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 22:42:37 -0400
Date: Sun, 24 Apr 2005 19:44:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Fabian Franz <FabianFranz@gmx.de>
cc: "David A. Wheeler" <dwheeler@dwheeler.com>, Paul Jakma <paul@clubi.ie>,
       Sean <seanlkml@sympatico.ca>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
In-Reply-To: <200504250417.17231.FabianFranz@gmx.de>
Message-ID: <Pine.LNX.4.58.0504241938410.18901@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <200504250417.17231.FabianFranz@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Fabian Franz wrote:
> 
> What about just <sha1 hash of object>.sig or <sha1 hash of object>.asc?

Well, the SHA1 of an object really is not a very good name, unless you 
have something to manage it with. Again, the object database has something 
to manage and find those objects with - things like .git/HEAD, but also 
"fsck" to find dangling and unnamed objects.

Maybe we'll never have so many tags that we need to manage them, and yes,
if so, we can just have ".git/signatures" be a directory with objects that
are just named for their content SHA1, the same way the object database
is, but separately (and probably just using a flat file structure, no need
for the subdirectory fan-out that the object directory has).

No need for a ".sig" thing, since they'd be defined to be signatures just 
from their location.

> Or would this violate the concept of the object database to just contain 
> hashes?

This wouldn't be an object at all in that case, they'd be totally outside 
the scope of the git object model.

And yes, if they were to be git objects, they'd follow totally different
rules: they'd have to have the "tag+length+'\0'" format, and they would be 
zlib-compressed.

If they are totally outside of git, then I don't care what the object 
format is, and then it could be just a regular text-file with a signature 
and content, and just happen to be named for the SHA1 hash so that there 
is no confusion about what happens when multiple people happen to create 
different tags with the same name.

		Linus
