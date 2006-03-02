Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWCBEE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWCBEE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWCBEE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:04:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750851AbWCBEEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:04:25 -0500
Date: Wed, 1 Mar 2006 20:03:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Kerrisk <mtk-manpages@gmx.net>
cc: Janak Desai <janak@us.ibm.com>, akpm@osdl.org, ak@muc.de, hch@lst.de,
       paulus@samba.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: unhare() interface design questions and man page
In-Reply-To: <19847.1141270261@www008.gmx.net>
Message-ID: <Pine.LNX.4.64.0603011959340.22647@g5.osdl.org>
References: <43F8B05B.4090707@us.ibm.com> <19847.1141270261@www008.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Mar 2006, Michael Kerrisk wrote:
> > >>>>>
> > >>>>> That is, CLONE_FS, CLONE_FILES, and CLONE_VM *reverse* the 
> > >>>>> effects of the clone() flags of the same name, but CLONE_NEWNS 
> > >>>>> *has the same meaning* as the clone() flag of the same name.

Well, if this is the only problem, who cares? CLONE_NEWNS itself is 
actually a reversal of clone flags: unlike the others, that tell to 
_share_ things that normally aren't shared across a fork(), CLONE_NEWNS 
does the opposite: it asks to unshare something that normally is shared.

So the fact that it then acts not as a reversal when doing "unshare()" is 
actually consistent with the fact that it's a already a "unshare" event 
for clone() itself.

> Do you have any further response on this point?
> (There was none in your last message?)

I personally don't think it's worth makign UNSHARE_NEWNS just because it's 
a flag that acts differently from the other CLONE_xxx flags.

As to whether allow or not allow unknown unshare() flags, I don't think 
it's a huge deal either way. Right now we don't check the flags to 
"clone()" either, I think.

		Linus
