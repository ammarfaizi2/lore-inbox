Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWBSOSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWBSOSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 09:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWBSOSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 09:18:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50185 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932519AbWBSOSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 09:18:41 -0500
Date: Sun, 19 Feb 2006 15:18:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org, rusty@rustcorp.com.au
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060219141808.GA30857@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060219113630.GA5032@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219113630.GA5032@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 12:36:30PM +0100, Sam Ravnborg wrote:
> 
> Question: Several modules contains init_module() cleanup_module() -
> for example floppy.o. I cannot see they are used anymore and subject for
> deletion - correct?

Digged a bit further into this.
In init.h the module_init() / module_exit() macros are defined.
They define an alias from the supplied function to
init_module() / cleanup_module().

Users of init_module() / cleanup_module() do have a ifdef section like
this:

#ifdef MODULE
init_module() ...
cleanup_module() ...
#else
module_init(modulename_init);
module_exit(modulename_exit);
#endif

So this seems to be modules that just needs a bit more
porting to the new module structure if I get it right.

What I missed when I asked the question was the #ifdef MODULE part.

	Sam
