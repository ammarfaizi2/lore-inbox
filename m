Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263329AbUKZXDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbUKZXDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUKZTtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:49:13 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262387AbUKZT3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:05 -0500
Date: Thu, 25 Nov 2004 21:01:37 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com> <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 04:20:06PM -0200, Alexandre Oliva wrote:
> This means these headers shouldn't reference each other as
> linux/user/something.h, but rather as linux/something.h, such that
> they still work when installed in /usr/include/linux.  This may
> require headers include/linux/something.h to include
> linux/user/something.h, but that's already part of the proposal.

That's going to take severe brain-ache to get right ... and worse,
keep right.  These headers aren't going to get tested outside the kernel
tree often.  So we'll have missing includes and files that only work if
the <linux/> they're including is a kernel one rather than a user one.

I'm not particularly stuck on the <user/> namespace.  We could invent
a better name.  How about <kern/> and <arch/> to replace <linux/>
and <asm/>?  Obviously keeping linux/ and asm/ symlinks for backwards
compatibility.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
