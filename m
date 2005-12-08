Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbVLHWus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbVLHWus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVLHWus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:50:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51910 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932691AbVLHWur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:50:47 -0500
Date: Thu, 8 Dec 2005 23:50:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051208225027.GA3970@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <200512071217.41814.rjw@sisk.pl> <20051207113003.GD2563@elf.ucw.cz> <200512082342.38759.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512082342.38759.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Let me explain what I have in mind.
> > > 
> > > For starters, please observe that the addresses we use are page-aligned,
> > > so the least significant bit is always zero.  Thus it can be used as a marker.
> > > 
> > > Now before we save the image we can mark blank pages by setting
> > > the least significant bit of .orig_address to 1 in the coresponding PBEs.
> > > We save the "marked" .orig_address values to the image.
> > 
> > Well, nice optimalization, but how many pages are actually full of
> > zeros?
> 
> According to the results I have obtained, there are about 1000 such
> pages in the image on my box, for total image sizes between 28000
> and 80000 pages (ie above 28000 of pages in the image the number
> of blank pages is almost constant).

4MB of zeros. I'd say that ewe have bigger problems to
solve. Detecting zero pages is actually very trivial form of
compression, and I think that we might as well do it properly, and use
something like LZW -- if we want to go that way. I think that should
be userspace problem.
							Pavel

-- 
Thanks, Sharp!
