Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTDSED2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 00:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTDSED2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 00:03:28 -0400
Received: from dp.samba.org ([66.70.73.150]:29385 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263258AbTDSED1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 00:03:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup 
In-reply-to: Your message of "Fri, 18 Apr 2003 04:10:17 -0400."
             <3E9FB2E9.9040308@pobox.com> 
Date: Sat, 19 Apr 2003 14:14:00 +1000
Message-Id: <20030419041526.5E3982C093@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E9FB2E9.9040308@pobox.com> you write:
> Rusty Trivial Russell wrote:
> > +char *kstrdup(const char *s, int gfp)
> > +{
> > +	char *buf = kmalloc(strlen(s)+1, gfp);
> > +	if (buf)
> > +		strcpy(buf, s);
> > +	return buf;
> > +}
> 
> You should save the strlen result to a temp var, and then s/strcpy/memcpy/

Completely disagree.  Write the most straightforward code possible,
and then if there proves to be a problem, optimize.  Optimizations
where there's no actual performance problem should be left to the
compiler.

Case in point: gcc-3.2 on -O2 on Intel is one instruction longer for
your version.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
