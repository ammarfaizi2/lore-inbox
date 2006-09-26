Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWIZPys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWIZPys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIZPyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:54:46 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:56805 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S932146AbWIZPy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:54:29 -0400
Subject: Re: [PATCH 7/7] SLIM: documentation
From: David Safford <safford@watson.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge E Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
In-Reply-To: <20060919191643.GA7246@elf.ucw.cz>
References: <1158083888.18137.18.camel@localhost.localdomain>
	 <20060919191643.GA7246@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 11:54:45 -0400
Message-Id: <1159286085.4718.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 21:16 +0200, Pavel Machek wrote: 
> Hi!
> 
> > Documentation.
> 
> Thanks for it.
> 
> > +file /etc/resolv.conf, dbus-daemon, which accepts data from
> > +potentially untrusted processes, Xorg, which has to accept data
> > +from all Xwindow clients, regardless of level, and postfix which
> > +delivers untrusted mail. Again, these applications inherently
> > +must cross trust levels, and SLIM properly identifies them.
> 
> How is this supposed to work. Xorg was not designed to be security
> barrier. So... your exploited evolution, but evolution is now
> UNTRUSTED, so you can't do anything interesting... right?
> 
> Wrong. evolution can ask Xorg to simulate "rm -rf /" keypresses, and
> send them to your shell in another window...

On one hand, I thought that allowSendEvents and editresBlock
specifically blocked synthetic keypresses from shell windows like 
xterm. On the other hand, I do agree that the X server
can provide dangerous communications between levels, and needs to
be fixed in some way. (dbus and Orbit have similar problems.)

Slim and selinux can control X access through socket labels, so there
are several options, based on your choice of policy:
  - you can run in "single level at a time" mode, in which all processes
    have to be at the same level, such as untrusted. This is safe, but
    pretty unusable, as you have to have separate logins for each level.
  - you can make the server a guard process, so that it can accept 
    connections from applications at any level. This is not generally
    safe as you point out, but is transparent to the user, and works
    for now.
  - you can add the necessary MAC checks into the X server, so that
    it enforces the local policy. This is safe, and convenient, but
    requires some patches to the server. NSA has started this work
    as part of LSM/selinux. See 
http://www.nsa.gov/selinux/papers/x11/t1.html

The documentation should have explained we are doing the second,
temporarily, until the X (and dbus, and Orbit) hooks are available.

dave


