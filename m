Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUE0Sdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUE0Sdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUE0Sdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:33:36 -0400
Received: from cpe-66-87-73-84.ca.sprintbbd.net ([66.87.73.84]:253 "EHLO
	elrond.shiresoft.com") by vger.kernel.org with ESMTP
	id S264957AbUE0Sd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:33:26 -0400
Subject: Re: 4k stacks in 2.6
From: Guy Sotomayor <ggs@shiresoft.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Brian Gerst <bgerst@didntduck.org>,
       Ingo Molnar <mingo@elte.hu>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0405270754360.1648@ppc970.osdl.org>
References: <20040525211522.GF29378@dualathlon.random>
	 <20040526103303.GA7008@elte.hu>
	 <20040526125014.GE12142@wohnheim.fh-wedel.de>
	 <20040526125300.GA18028@devserv.devel.redhat.com>
	 <20040526130047.GF12142@wohnheim.fh-wedel.de>
	 <20040526130500.GB18028@devserv.devel.redhat.com>
	 <20040526164129.GA31758@wohnheim.fh-wedel.de>
	 <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random>
	 <40B5F8C0.2010005@didntduck.org> <20040527145033.GF3889@dualathlon.random>
	 <Pine.LNX.4.58.0405270754360.1648@ppc970.osdl.org>
Content-Type: text/plain
Organization: ShireSoft
Message-Id: <1085682709.5910.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 27 May 2004 11:31:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 07:55, Linus Torvalds wrote:

> "minor implementation detail"?
> 
> You need to get to the thread info _some_ way, and you need to get to it
> _fast_. There are really no sane alternatives. I certainly do not want to
> play games with segments.

While segments on x86 are in general to be avoided (aka the 286
segmented memory models) they can be useful for some things in the
kernel.

Here's a couple of examples:
      * dereference gs:0 to get the thread info.  The first element in
        the structure is its linear address (ie usable for being deref'd
        off of DS).
      * use SS to enforce the stack limit.  This way you'd absolutely
        get an exception when there was a stack overflow (underflow). 
        SS gets reloaded on entry into the kernel and on interrupts
        anyway so there really shouldn't be a performance impact.  I
        haven't looked at all the (potential) gcc implications here so
        this one may not be completely doable.
-- 

TTFN - Guy

