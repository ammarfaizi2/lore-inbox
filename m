Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWFYVWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWFYVWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 17:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWFYVWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 17:22:16 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:2206 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751019AbWFYVWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 17:22:15 -0400
Date: Sun, 25 Jun 2006 23:21:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       sekharan@us.ibm.com, rusty@rustcorp.com.au, rdunlap@xenotime.net
Subject: Re: 2.6.17-mm2
Message-ID: <20060625212113.GA13702@mars.ravnborg.org>
References: <20060624061914.202fbfb5.akpm@osdl.org> <20060624172014.GB26273@redhat.com> <20060624143440.0931b4f1.akpm@osdl.org> <200606251051.55355.rjw@sisk.pl> <20060625032243.fcce9e2e.akpm@osdl.org> <20060625081610.9b0a775a.akpm@osdl.org> <20060625182352.GB17945@mars.ravnborg.org> <20060625114051.e9d5cbde.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625114051.e9d5cbde.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 11:40:51AM -0700, Andrew Morton wrote:
 > > 
> > > IOW, any reference from __ksymtab, __ksymtab_gpl or __ksymtab_gpl_future
> > > into __init or __initdata should be a hard error.
> > We could let modpost error out. Then the module does not get build but
> > we detect it a bit later than optimal.
> > 
> 
> Well, it doesn't have anything to do with modules per-se.  When vmlinux is
> post-processed we want to error out if vmlinux is exporting any
> __init/__initdata symbols to modules.

modpost has evolved over time and when I get the time I will refactor
kbuild so we always call modpost in the final steps of the kernel build
independent on module support or not. And then is makes perfect sense
to have the check for exported symbols from illegal sections located
there.
In other words current modpost will be used also when
executing "make vmlinux". That impose a few tricky things and I have
posponed it for now. Implementing the suggested check should be possible
and will try to look at that sooner.

	Sam

