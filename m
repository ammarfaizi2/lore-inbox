Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269650AbTGUK61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 06:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTGUK60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 06:58:26 -0400
Received: from dp.samba.org ([66.70.73.150]:48092 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269650AbTGUK6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 06:58:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: azarah@gentoo.org
Cc: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: KML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: devfsd/2.6.0-test1 
In-reply-to: Your message of "21 Jul 2003 00:48:56 +0200."
             <1058741336.19817.147.camel@nosferatu.lan> 
Date: Mon, 21 Jul 2003 21:09:24 +1000
Message-Id: <20030721111327.DFC682C21F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1058741336.19817.147.camel@nosferatu.lan> you write:
> > modprobe.conf syntax is easy to implement but unfortunately PITA
> > to use.  Exactly probe and probeall have been very helful in
> > tracking module dependencies. Now you have arbitrary shell line
> > that is near to impossible to parse in general.

Sure.  But probe and probeall isn't enough.  You'll also want
conditionals in the parsing of the config file, so you can do
different things on different architectures or different kernel
levels.  You're going to lose, here, if you try to be general 8(

We already have one hook to do arbitrary things, and I think it's
quite neat:

	# Sound is complex.
	install sound-slot-0 /sbin/configure-sound

Now, if you want to implement a meta-language that does all this,
great!  But I'm resisting new features in the base, because I have to
support them, and I'm incredibly lazy.

Modules already have their own hard and soft dependencies.  If you
have an incredibly complex modprobe.conf, it's worth asking whether
the correct solution is to make modprobe.conf's syntax more powerful,
or look at making a more fundamental change...

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
