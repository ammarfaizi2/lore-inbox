Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVDMO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVDMO6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVDMO6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:58:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:55725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261339AbVDMO6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:58:04 -0400
Date: Wed, 13 Apr 2005 07:59:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
In-Reply-To: <1113403661.20848.144.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0504130757530.4501@ppc970.osdl.org>
References: <20050409200709.GC3451@pasky.ji.cz>  <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
  <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> 
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>  <20050410024157.GE3451@pasky.ji.cz>
 <20050410162723.GC26537@pasky.ji.cz>  <20050411015852.GI5902@pasky.ji.cz>
 <20050411135758.GA3524@pasky.ji.cz>  <1113311256.20848.47.camel@hades.cambridge.redhat.com>
  <20050413094705.B1798@flint.arm.linux.org.uk>  <20050413085954.GA13251@pasky.ji.cz>
  <1113384304.12012.166.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0504130732230.4501@ppc970.osdl.org>
 <1113403661.20848.144.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2005, David Woodhouse wrote:
> 
> > In other words, that index file simply _cannot_ be shared. Don't even
> > think about it. Only madness will ensue.
> 
> If I use git in my home directory I cannot _help_ but share it.
> Sometimes I'm using it from a BE box, sometimes from a LE box. Should I
> really be forced to use separate checkouts for each type of machine?

Now, that kind of "private sharing" should certainly be ok. In fact, the 
only locking there is (doing the ".git/index.lock" thing around any 
updates and erroring out if it already exists) was somewhat designed for 
that. So making it use BE data (preferred just because then you can use 
the existing htonl() etc helpers in user space) would work. 

As long as people don't think this means anything else... It really is a 
private file.

		Linus
