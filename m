Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUBGDdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUBGDdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:33:32 -0500
Received: from mail.shareable.org ([81.29.64.88]:34768 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266578AbUBGDd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:33:27 -0500
Date: Sat, 7 Feb 2004 03:33:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: avoiding dirty code pages with fixups
Message-ID: <20040207033324.GB13986@mail.shareable.org>
References: <20040203225453.GB18320@hexapodia.org> <20040207001317.GE12503@mail.shareable.org> <20040207030343.GB21565@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207030343.GB21565@hexapodia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> On Sat, Feb 07, 2004 at 12:13:17AM +0000, Jamie Lokier wrote:
> > > The downside is the additional computation on page-in.
> > 
> > > It is a function of how many fixups there are per page, and of how
> > > much work ld.so does to satisfy a fixup.  I don't have a good feel
> > > for how expensive ld.so's fixup mechanism is... any comments?
> > 
> > The other downside of your idea is that every instance of a program
> > has more dirty pages.  While it is true that the pages do not require
> > disk I/O, they still take up RAM that could be used for other page
> > cache things.
> 
> Well, in the case I describe, currently they're done with MAP_PRIVATE
> mappings, so it's no net loss.

Ok, that's a good point.

When you brought it up in the context of our vsyscall fla^H^H^Hdebate,
I assumed you meant to use this as a technique to help fixing up more
code pointers at run time, to convert indirect jumps to direct ones.
That does dirty more pages.

Your idea of the reverted pages conveniently containing the right code
to get them patched again is quite clever, imho.

-- Jamie
