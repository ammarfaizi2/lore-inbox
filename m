Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965560AbWI0LIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965560AbWI0LIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965564AbWI0LIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:08:43 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:15010 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S965560AbWI0LIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:08:42 -0400
Subject: Re: 2.6.18-mm1 compile failure on x86_64
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Andi Kleen <ak@suse.de>
Cc: Andre Noll <maan@systemlinux.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200609271226.44834.ak@suse.de>
References: <45185A93.7020105@google.com>
	 <m1venaqeg6.fsf@ebiederm.dsl.xmission.com>
	 <20060927095839.GK20462@skl-net.de>  <200609271226.44834.ak@suse.de>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 12:08:49 +0100
Message-Id: <1159355329.28313.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2006 11:08:39.0745 (UTC) FILETIME=[49434310:01C6E225]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 12:26 +0200, Andi Kleen wrote:
> We can probably revert the notes patch for now, since it is only
> needed for Xen which isn't even merged yet.

We could apply the fix which moves the .bss after the .data sections.
The bug report after you originally applied that patch looked to me like
it was an existing bug which was exposed so it would probably be worth
tracking down the root cause of that one rather than rejecting that
patch as a possible solution.

The xen-unstable tree has had the .bss movement patch in for a couple of
weeks now with no reported bugs. We are frozen for the release 3.0.3 so
at least in theory people should be testing it pretty hard ;-)

> Ian, do you think you can do the notes in some different way that still
> works with old binutils?

I'm not sure. 	I think the notes themselves are generated fine the
problem lies in the change to the linker script to gather all
the .notes.* sections into the same PT_NOTES segment, that is something
Jeremy did for i386 and I just copied.

Do the notes really need to be gathered together? I we could make Xen
look for .notes.* sections as well as the PT_NOTES segment but I would
prefer to use the segment if possible...

Ian.


