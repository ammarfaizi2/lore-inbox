Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTEUH7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTEUH4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:56:10 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261747AbTEUHnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:12 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Riley Williams <Riley@Williams.Name>,
       David Woodhouse <dwmw2@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <3ECA60B0.6040402@zytor.com>
References: <BKEGKPICNAKILKJKMHCAGECEDBAA.Riley@Williams.Name>
	 <3ECA3535.7090608@nortelnetworks.com>  <3ECA60B0.6040402@zytor.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053491987.9142.1474.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 21 May 2003 06:39:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-20 at 19:06, H. Peter Anvin wrote:

> > What if the include/linux files themselves make use of the asm files?
> > 
> 
> No, not acceptable.
> 
> The thing is, trying to redefine the old namespaces is hopeless at this 
> point.  Hence the proposed new namespace <linux/abi/*.h> ... 
> <linux/abi/arch/*.h> would be my preference for an arch-specific 
> subnamespace.
> 
> Thus the rule is:
> 
> a) <linux/abi/*> files MUST NOT include files outside <linux/abi/*>
> 
> b) <linux/*.h> and <asm/*.h> are legacy namespaces.  They should be 
> considered to be completely different in kernel and userspace -- in 
> effect, glibc will eventually ship with its own set of these headers.
> 
> c) <linux/abi/*> files should be clean for inclusion from either kernel 
> or userspace.
> 

The only issue that we might have, is that <linux/abi/*> will once
again break many things.  Sure, if we have to fix them once to get
this fixed for good, why not.

On the other hand, why not leave it at <linux/*.h> and <asm/*.h>
as the location of the ABI, and then move all kernel only
related stuff to <kernel/*.h> (or whatever, just the concept which
count ...) which can then include whatever it needs form the other
places (linux/asm)?


Regards,

-- 
Martin Schlemmer


