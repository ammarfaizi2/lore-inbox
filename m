Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTEUHzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTEUHmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:42:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58838 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261678AbTEUHl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:56 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Martin Schlemmer <azarah@gentoo.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Riley Williams <Riley@Williams.Name>,
       David Woodhouse <dwmw2@infradead.org>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <BKEGKPICNAKILKJKMHCAGECEDBAA.Riley@Williams.Name>
	<3ECA3535.7090608@nortelnetworks.com> <3ECA60B0.6040402@zytor.com>
	<1053491987.9142.1474.camel@workshop.saharact.lan>
	<3ECB10BD.8070105@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 May 2003 23:58:05 -0600
In-Reply-To: <3ECB10BD.8070105@zytor.com>
Message-ID: <m1llx0q1si.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Martin Schlemmer wrote:
> > The only issue that we might have, is that <linux/abi/*> will once
> > again break many things.  Sure, if we have to fix them once to get
> > this fixed for good, why not.
> > On the other hand, why not leave it at <linux/*.h> and <asm/*.h>
> > as the location of the ABI, and then move all kernel only
> > related stuff to <kernel/*.h> (or whatever, just the concept which
> > count ...) which can then include whatever it needs form the other
> > places (linux/asm)?
> >
> 
> Because then there will be a push to be backward compatible, and the current
> structure is hideously poor for this purpose.

In fact all but the most kernel dependent programs should still
not be using these headers directly.

Given that glibc plays interesting tricks with dev_t and friends.
Only an application that knows what it is doing should bypass
glibcs abstraction layer.  

Mostly these headers will be there for glibc to include, and rexport
in sys/*

Eric
