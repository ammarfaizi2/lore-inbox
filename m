Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269770AbUICUdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269770AbUICUdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUICUdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:33:52 -0400
Received: from trantor.org.uk ([213.146.130.142]:63441 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S269782AbUICUbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:31:33 -0400
Subject: Re: Userspace framework (was: Re: silent semantic changes with
	reiser4)
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Luca Ferroni <fferroni@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org, miklos@szeredi.hu, renzo@cs.unibo.it,
       frederik@a5.repetae.net
In-Reply-To: <20040903112435.0d754fac.fferroni@cs.unibo.it>
References: <rlrevell@joe-job.com>
	 <1094079071.1343.25.camel@krustophenia.net>
	 <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
	 <1535878866.20040902214144@tnonline.net>
	 <20040902194909.GA8653@atrey.karlin.mff.cuni.cz>
	 <1094155277.11364.92.camel@krustophenia.net>
	 <20040902204351.GE8653@atrey.karlin.mff.cuni.cz>
	 <1094158060.1347.16.camel@krustophenia.net>
	 <20040902205857.GF8653@atrey.karlin.mff.cuni.cz>
	 <1094164385.6163.4.camel@localhost.localdomain>
	 <1094181768.9282.27.camel@sherbert>
	 <20040903112435.0d754fac.fferroni@cs.unibo.it>
Content-Type: text/plain
Date: Fri, 03 Sep 2004 21:31:22 +0100
Message-Id: <1094243482.6632.66.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 11:24 +0200, Luca Ferroni wrote:
> Il Fri, 03 Sep 2004 04:22:48 +0100,  Gianni Tedesco <gianni@scaramanga.co.uk> ha scritto:
> 
> > On Thu, 2004-09-02 at 23:33 +0100, Alan Cox wrote:
> > > On Iau, 2004-09-02 at 21:58, Pavel Machek wrote:
> > > > Uservfs.sf.net.
> > > > 
> > > > Unlike alan, I do not think that "do it all in library" is good
> > > > idea. I put it in the userspace as "codafs" server, and let
> > > > applications see it as a regular filesystem.
> > > 
> > > That works for me too, providing someone has fixed all the user mode fs
> > > deadlocks with paging
> > 
> > Aren't the deadlock scenarios only applicable for read/write mounted
> > filesystems ?
> > 
> 
> AFAIK deadlock arises when kernel manages buffers:
> it has to free a buffer ==> choose a dirty one ==> if cleaning
> requires to make a call to
> network server and this last is waiting for a buffer (cleaning
> accomplished) ==>
> ==> deadlock.

so during page launder, we need to write to the filesystem, but if thats
in userspace there is the possibility the page launder could have been
caused in order that the filesystem daemon may run. AFAICS this problem
only arises when file is being written.

The only deadlock I can think of for read-only filesystems is if the
demon inadvertantly accesses one of the files that it is handling. That
could be avoided quite simply by preventing the demon from doing that in
the kernel.

I'm sure I'm missing something, I'd just like to know what ;)

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

