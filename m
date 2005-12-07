Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVLGLae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVLGLae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVLGLae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:30:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12233 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750890AbVLGLae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:30:34 -0500
Date: Wed, 7 Dec 2005 12:30:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051207113003.GD2563@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <200512070205.37414.rjw@sisk.pl> <20051207011019.GA2233@elf.ucw.cz> <200512071217.41814.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512071217.41814.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'm suggesting that rather than writing the clean pages out to the
> > > > image, simply make their metadata available to a post-resume userland
> > > > helper.  Something like
> > > > 
> > > > % head -2 /dev/swsusp-helper
> > > > /bin/sh 105-115 192 199-259
> > > > /lib/libc-2.3.2.so 1-250
> > > > 
> > > > where the userland program is expected to use the list of page numbers
> > > > (and getpagesize(2)) to asynchronously page in the working set in an
> > > > ionice'd manner.
> > > 
> > > The helper is not necessary, I think.
> > 
> > Actually, I like the helper. It is safest solution,
> 
> No, it's not.
> 
> Let me explain what I have in mind.
> 
> For starters, please observe that the addresses we use are page-aligned,
> so the least significant bit is always zero.  Thus it can be used as a marker.
> 
> Now before we save the image we can mark blank pages by setting
> the least significant bit of .orig_address to 1 in the coresponding PBEs.
> We save the "marked" .orig_address values to the image.

Well, nice optimalization, but how many pages are actually full of
zeros? Above has advantage of working with any "clean" pages -- like
text pages of /bin/bash etc. And if done right it will not be
intrusive...

								Pavel
-- 
Thanks, Sharp!
