Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVCNQ2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVCNQ2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVCNQ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:28:35 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:19627 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261575AbVCNQ10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:27:26 -0500
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
From: Albert Cahalan <albert@users.sf.net>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
In-Reply-To: <42355C78.1020307@lsrfire.ath.cx>
References: <1110771251.1967.84.camel@cube>
	 <42355C78.1020307@lsrfire.ath.cx>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 11:13:23 -0500
Message-Id: <1110816803.1949.177.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 10:42 +0100, Rene Scharfe wrote:
> Albert Cahalan wrote:
> > This is a bad idea. Users should not be allowed to
> > make this decision. This is rightly a decision for
> > the admin to make.
> 
> Why do you think users should not be allowed to chmod their processes' 
> /proc directories?  Isn't it similar to being able to chmod their home 
> directories?  They own both objects, after all (both conceptually and as 
> attributed in the filesystem).

This is, to use your own word, "cloaking". This would let
a bad user or even an unauthorized user hide from the admin.
Why should someone be able to hide a suspicious CPU hog?
Maybe they are cracking passwords or selling your CPU time.

Note that the admin hopefully does not normally run as root.
The admin should be using a normal user account most of the
time, to reduce the damage caused by his accidents.

Even if the admin were not running as a normal user, it is
expected that normal users can keep tabs on each other.
The admin may be sleeping. Social pressure is important to
prevent one user from sucking up all the memory and CPU time.

> > Note: I'm the procps (ps, top, w, etc.) maintainer.
> > 
> > Probably I'd have to make /bin/ps run setuid root
> > to deal with this. (minor changes needed) The same
> > goes for /usr/bin/top, which I know is currently
> > unsafe and difficult to fix.
> > 
> > Let's not go there, OK?
> 
> I have to admit to not having done any real testing with those 
> utilities.  My excuse is this isn't such a new feature, Openwall had 
> something similar for at least four years now and GrSecurity contains 
> yet another flavour of it.  Openwall also provides one patch for 
> procps-2.0.6, so I figured that problem (whatever their patch is about) 
> got fixed in later versions.

If I haven't seen that patch, to Hell with 'em.

It appears that Openwall is using procps-2.0.7 now. Oooh, they've
upgraded to something that's only 4.5 years old! Anybody using a
4-year-old procps is uninterested in security.

> Why do ps and top need to be setuid root to deal with a resticted /proc? 
>     What information in /proc/<pid> needs to be available to any and all 
> users?

Anything provided by traditional UNIX and BSD systems
should be available. Users who want privacy can get their
own computer. So, these need to work:

ps -ef
ps -el
ps -ej
ps axu
ps axl
ps axj
ps axv
w
top

Note that /proc does provide a bit more info than required.
This could be changed; it requires new /proc files or a
non-proc source of data.

> > If you restricted this new ability to root, then I'd
> > have much less of an objection. (not that I'd like it)
> 
> How about a boot parameter or sysctl to enable the chmod'ability of 
> /proc/<pid>, defaulting to off?  But I'd like to resolve your more 
> general objections above first, if possible. :)

This at least avoids breaking the traditional ability of
non-root users to spot abuse.


