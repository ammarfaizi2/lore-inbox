Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269938AbUIDBCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269938AbUIDBCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 21:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbUIDBCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 21:02:45 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:44708 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269938AbUIDAv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:51:29 -0400
Date: Sat, 4 Sep 2004 01:51:24 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0409040145240.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Then drm_core would always be bundled with the OS.
>
> Is there any real advantage to spliting core/library and creating three
> interface compatibily problems?

Yes we only have one binary interface, between the core and module, this
interface is minimal, so AGP won't go in it... *ALL* the core does is deal
with the addition/removal of modules, the idea being that the interface is
very minor and new features won't change it...

The library/driver interface then becomes a source interface as the
library isn't a separate module, it is linked into the modules, so we have
no binary interface issues with it, so the library/driver interface is
what we have at the moment minus the uglyness of DRM() and templated
header files... so if a vendor wants to ship a binary DRM, they only worry
about the drm core interface, and we avoid moving that interface as all it
does is keep track of all installed drms and the major device number..

> What about the VM page fault routines with 2.4 vs 2.6 differences?
> How about HAS_WORKQUEUE?

These are things to worry about later, as I said the code was just
experimental hackery to get my head around the issues. I'm not proposing
it for inclusion at any point, it also doesn't follow the design I
proposed, it makes the library as a separate module at the moment, and
uses an EXPORT_SYMBOL table, which isn't what I want to do...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

