Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUEGDp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUEGDp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 23:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUEGDp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 23:45:26 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:911 "EHLO hibernia.jakma.org")
	by vger.kernel.org with ESMTP id S262766AbUEGDpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 23:45:25 -0400
Date: Fri, 7 May 2004 04:44:16 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Andrew Morton <akpm@osdl.org>
cc: arjanv@redhat.com, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
In-Reply-To: <20040506195002.520b0793.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405070433170.1979@fogarty.jakma.org>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net>
 <200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
 <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
 <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
 <20040506195002.520b0793.akpm@osdl.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Andrew Morton wrote:

> That's a misdiagnosis.  The problem here is that the kernel is
> taking a pagefault within show_trace(), and the pagefault handler
> calls show_trace().  It has gone infinitely recursive.

That happens after the initial stack overflow with a trace (from what
i could discern before it scrolled into oblivion) in NFS -> IP path
similar to the other non-recursive trace, see below.

> The bug is unrelated to the stack size.  It is in show_trace() or
> thereabouts.  That code tries to protect itself from recursive
> faults, but it's a vendor kernel and may be different from the
> public tree.

Fair enough but have a look at the other fault from that bug though:

	https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=99855&action=view 

That one did not recurse for some reason.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
The program isn't debugged until the last user is dead.
