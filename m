Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWCHGPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWCHGPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 01:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCHGPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 01:15:35 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:54671
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750881AbWCHGPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 01:15:35 -0500
Date: Tue, 7 Mar 2006 22:15:17 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: oops in choose_configuration()
Message-ID: <20060308061517.GA11451@kroah.com>
References: <200603071657_MC3-1-BA0F-6372@compuserve.com> <200603072222.11504.dtor_core@ameritech.net> <20060308052302.GA29867@kroah.com> <200603080107.00289.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603080107.00289.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 01:06:59AM -0500, Dmitry Torokhov wrote:
> On Wednesday 08 March 2006 00:23, Greg KH wrote:
> > > 
> > > Hmm, what is the policy for attr->show()? With hotplug variables we
> > > return -ENOMEM if there is not enough memory to store all data, but
> > > what about attributes? Should we also return error (and which one,
> > > -ENOMEM, -ENOBUFS?) or fill as much as we can and return up to
> > > PAGE_SIZE?
> > 
> > Remember, sysfs files are supposed to be small, you are an "oddity" in
> > that you have a much larger buffer that you can return due to the wierd
> > aliases you have.
> > 
> > Truncating the buffer is probably good as we want userspace to get some
> > information, right?
> > 
> > > With sysfs not kernel nor application can really recover
> > > if attribute needs buffer larger than a page. Or just rely on BUG_ON
> > > in fs/sysfs/file.c::fill_read_buffer()?
> > 
> > How about just making this a binary attribute, then you can handle an
> > arbitrary size buffer and don't have to worry about the PAGE_SIZE stuff
> > (but it makes it more code that you have to write to handle it all,
> > there are tradeoffs...)
> > 
> 
> I really don't believe that we ever going to cross 4096 boundary for any
> single input attribute, but just to code defensively we need to decide
> what to do if we ever encounter a crazy device. Just truncating to
> PAGE_SIZE is easiest so that's what I am going to do.

Ok, that's fine with me.

thanks,

greg k-h
