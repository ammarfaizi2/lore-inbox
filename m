Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVCOC6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVCOC6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVCOC6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:58:41 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:10120 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261504AbVCOC6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:58:36 -0500
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
From: Albert Cahalan <albert@users.sf.net>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com
In-Reply-To: <Pine.LNX.4.58.0503142333480.6357@be1.lrz>
References: <1110771251.1967.84.camel@cube>
	 <42355C78.1020307@lsrfire.ath.cx> <1110816803.1949.177.camel@cube>
	 <Pine.LNX.4.58.0503142333480.6357@be1.lrz>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 21:44:27 -0500
Message-Id: <1110854667.7893.203.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 00:08 +0100, Bodo Eggert wrote:
> On Mon, 14 Mar 2005, Albert Cahalan wrote:
> > On Mon, 2005-03-14 at 10:42 +0100, Rene Scharfe wrote:
> > > Albert Cahalan wrote:
> 
> > > Why do you think users should not be allowed to chmod their processes' 
> > > /proc directories?  Isn't it similar to being able to chmod their home 
> > > directories?  They own both objects, after all (both conceptually and as 
> > > attributed in the filesystem).
> > 
> > This is, to use your own word, "cloaking". This would let
> > a bad user or even an unauthorized user hide from the admin.
> 
> NACK, the admin (and with the new inherited capabilities all users with 
> cap_???_override) can see all processes. Only users who don't need to know
> won't see the other user's processes.

Capabilities are too broken for most people to use. Normal users
do not get CAP_DAC_OVERRIDE by default anyway, for good reason.

> > Note that the admin hopefully does not normally run as root.
> 
> su1 and sudo exist.

This is a pain. Now every user will need sudo access,
and the sudoers file will have to disable requesting
passwords so that scripts will work without hassle.

> > Even if the admin were not running as a normal user, it is
> > expected that normal users can keep tabs on each other.
> > The admin may be sleeping. Social pressure is important to
> > prevent one user from sucking up all the memory and CPU time.
> 
> Privacy is important, too. Imagine each user can see the CEO (or the
> admin) executing "ee nakedgirl.jpg".

Obviously, he likes to have users see him do this.
He'd use a private machine if he wanted privacy.

> > > > Note: I'm the procps (ps, top, w, etc.) maintainer.
> > > > 
> > > > Probably I'd have to make /bin/ps run setuid root
> > > > to deal with this. (minor changes needed) The same
> > > > goes for /usr/bin/top, which I know is currently
> > > > unsafe and difficult to fix.
> 
> I used unpatched procps 3.1.11, and it worked for me, except pstree.

It does not work correctly.

Look, patches with this "feature" are called rootkits.
Think of the headlines: "Linux now with built-in rootkit".

> > > Why do ps and top need to be setuid root to deal with a resticted /proc? 
> > >     What information in /proc/<pid> needs to be available to any and all 
> > > users?
> > 
> > Anything provided by traditional UNIX and BSD systems
> > should be available.
> 
> e.g. the buffer overflow in sendmail? Or all the open relays? :)
> 
> The demands to security and privacy have increased. Linux should be able 
> to provide the requested privacy.

This really isn't about security. Privacy may be undesirable.
With privacy comes anti-social behavior. Supposing that the
users do get privacy, perhaps because the have paid for it:

Xen, UML, VM, VMware, separate computers

Going with separate computers is best. Don't forget to use
network traffic control to keep users from being able to
detect the network activity of other users.

> > Users who want privacy can get their
> > own computer. So, these need to work:
> > 
> > ps -ef
> > ps -el
> > ps -ej
> > ps axu
> > ps axl
> > ps axj
> > ps axv
> > w
> > top
> 
> Works as intended. Only pstree breaks, if init isn't visible.

They work like they do with a rootkit installed.
Traditional behavior has been broken.


