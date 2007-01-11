Return-Path: <linux-kernel-owner+w=401wt.eu-S1030244AbXAKI6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbXAKI6x (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXAKI6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:58:53 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46122 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030245AbXAKI6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:58:52 -0500
To: Andrew Morton <akpm@osdl.org>
cc: Aubrey <aubreylee@gmail.com>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, torvalds@osdl.org,
       mjt@tls.msk.ru
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O_DIRECT question 
In-reply-to: Your message of Wed, 10 Jan 2007 20:51:57 PST.
             <20070110205157.4aca3689.akpm@osdl.org> 
Date: Wed, 10 Jan 2007 21:06:06 -0800
Message-Id: <E1H4s8d-0006he-0k@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2007 20:51:57 PST, Andrew Morton wrote:
> On Thu, 11 Jan 2007 10:57:06 +0800
> Aubrey <aubreylee@gmail.com> wrote:
> 
> > Hi all,
> >
> > Opening file with O_DIRECT flag can do the un-buffered read/write access.
> > So if I need un-buffered access, I have to change all of my
> > applications to add this flag. What's more, Some scripts like "cp
> > oldfile newfile" still use pagecache and buffer.
> > Now, my question is, is there a existing way to mount a filesystem
> > with O_DIRECT flag? so that I don't need to change anything in my
> > system. If there is no option so far, What is the right way to achieve
> > my purpose?
> 
> Not possible, basically.
> 
> O_DIRECT reads and writes must be aligned to the device's block size
> (usually 512 bytes) in memory addresses, file offsets and read/write request
> sizes.  Very few applications will bother to do that and will hence fail if
> their files are automagically opened with O_DIRECT.

Actually, technically possible.  We heard from some application people
that Sun/Solaris has this option.  Good if the application is the only
one using the filesystem.  Supposedly there were large apps which used
lots of filesystems more or less exclusively and this option made people
happy.

Although before Linus says it, I guess crack makes people happy, too.  ;)

gerrit
