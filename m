Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVCNXHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVCNXHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVCNXHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:07:33 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:35251 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262055AbVCNXFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:05:21 -0500
Date: Tue, 15 Mar 2005 00:08:46 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
In-Reply-To: <1110816803.1949.177.camel@cube>
Message-ID: <Pine.LNX.4.58.0503142333480.6357@be1.lrz>
References: <1110771251.1967.84.camel@cube>  <42355C78.1020307@lsrfire.ath.cx>
 <1110816803.1949.177.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Albert Cahalan wrote:
> On Mon, 2005-03-14 at 10:42 +0100, Rene Scharfe wrote:
> > Albert Cahalan wrote:

> > Why do you think users should not be allowed to chmod their processes' 
> > /proc directories?  Isn't it similar to being able to chmod their home 
> > directories?  They own both objects, after all (both conceptually and as 
> > attributed in the filesystem).
> 
> This is, to use your own word, "cloaking". This would let
> a bad user or even an unauthorized user hide from the admin.

NACK, the admin (and with the new inherited capabilities all users with 
cap_???_override) can see all processes. Only users who don't need to know
won't see the other user's processes.

> Note that the admin hopefully does not normally run as root.

su1 and sudo exist.

> Even if the admin were not running as a normal user, it is
> expected that normal users can keep tabs on each other.
> The admin may be sleeping. Social pressure is important to
> prevent one user from sucking up all the memory and CPU time.

Privacy is important, too. Imagine each user can see the CEO (or the
admin) executing "ee nakedgirl.jpg".

> > > Note: I'm the procps (ps, top, w, etc.) maintainer.
> > > 
> > > Probably I'd have to make /bin/ps run setuid root
> > > to deal with this. (minor changes needed) The same
> > > goes for /usr/bin/top, which I know is currently
> > > unsafe and difficult to fix.

I used unpatched procps 3.1.11, and it worked for me, except pstree.

> > Why do ps and top need to be setuid root to deal with a resticted /proc? 
> >     What information in /proc/<pid> needs to be available to any and all 
> > users?
> 
> Anything provided by traditional UNIX and BSD systems
> should be available.

e.g. the buffer overflow in sendmail? Or all the open relays? :)

The demands to security and privacy have increased. Linux should be able 
to provide the requested privacy.

> Users who want privacy can get their
> own computer. So, these need to work:
> 
> ps -ef
> ps -el
> ps -ej
> ps axu
> ps axl
> ps axj
> ps axv
> w
> top

Works as intended. Only pstree breaks, if init isn't visible.

> > > If you restricted this new ability to root, then I'd
> > > have much less of an objection. (not that I'd like it)
> > 
> > How about a boot parameter or sysctl to enable the chmod'ability of 
> > /proc/<pid>, defaulting to off?  But I'd like to resolve your more 
> > general objections above first, if possible. :)

I'd prefer a minimum and a maximum mask. If the admin wants to enforce 
privacy, he can do it, and if he wants the users to spy on each other, so 
be it.
-- 
Top 100 things you don't want the sysadmin to say:
23. What do mean by "fired"?

Friﬂ, Spammer: kRT8@[211.158.7.114] hire@wjkwwi.info
